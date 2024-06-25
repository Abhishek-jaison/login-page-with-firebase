import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/components/my_button.dart';
import 'package:login_with_firebase/components/my_text_field.dart';
import 'package:login_with_firebase/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  
  final void Function()? onTap;
  LoginPage({required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  //login method 
  void login() async {
    //show loading circle
    showDialog(context: context,
    builder: (context)=> const Center(
      child: CircularProgressIndicator(),
    ));

    //try sign in
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
    
    //pop loading circle
    if(context.mounted) Navigator.pop(context);
    
    }
    //display error
    on FirebaseAuthException catch(e){
      //pop loading cirlce
      Navigator.pop(context);
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
              MyButton(text: 'Login',
               onTap: login,
               ),
              SizedBox(height: 25,),
              
              //dont have a account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Register Here",
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