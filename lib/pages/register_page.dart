import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/components/my_button.dart';
import 'package:login_with_firebase/components/my_text_field.dart';

import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernamecontroller = TextEditingController();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController confirmPwcontroller = TextEditingController();

  //Register method 
  void registerUser() async {
      //show loading circle
      showDialog(
        context: context, 
        builder: (context) => const Center(
          child :CircularProgressIndicator(),
        ));


      //make shure passwords match
      if(passwordcontroller.text != confirmPwcontroller.text){
        //pop loading circle
      Navigator.pop(context);

        //show error message to user
        displayMessageToUser("Passwords don't match!", context);
      }

      //try creating user

      try{
      //create the user
      UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
      
      //pop loading circle
      Navigator.pop(context);
      }
      on FirebaseAuthException catch(e){
        //pop loading circle
        Navigator.pop(context);

        //display error message
        displayMessageToUser(e.code, context);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              //logo
              Icon(Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,),
              const SizedBox(height: 25,),
          
              //app name
               const Text('M I N I M A L',
                style: TextStyle(fontSize: 20),),
                SizedBox(height: 50,),
              
              //username
              MyTextField(hintText: 'Username',
               obscureText: false,
              controller: usernamecontroller),
              const SizedBox(height: 10,),

              //email
              MyTextField(hintText: 'Email',
               obscureText: false,
              controller: emailcontroller),
              const SizedBox(height: 10,),

              //pasword
              MyTextField(hintText: 'Password',
               obscureText: true,
              controller: passwordcontroller),
              const SizedBox(height: 10,),
          
              //conform pasword
              MyTextField(hintText: 'Confirm Password',
               obscureText: true,
              controller: confirmPwcontroller),
              const SizedBox(height: 10,),
          
              
              
              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Password',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),)
                ],
              ),
              SizedBox(height: 25,),

              //sign in button
              MyButton(text: 'Register',
               onTap: registerUser,
               ),
              SizedBox(height: 25,),
              
              //dont have a account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Login Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),)
                ],
              )
          
          
          
          
          ],),
        ),
      ),
    );
  }
}