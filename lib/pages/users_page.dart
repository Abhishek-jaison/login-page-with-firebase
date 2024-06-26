import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/components/my_back_button.dart';
import 'package:login_with_firebase/components/my_list_tile.dart';
import 'package:login_with_firebase/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream : FirebaseFirestore.instance.collection("Users").snapshots(),
        builder:(context, snapshot){
          //any errors  
          if(snapshot.hasError){
            displayMessageToUser('Something went wrong', context);
          }


          //show loading 
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());}
          if(snapshot.data == null){
            return const Text('No data');
          }

          // get all users
          final users = snapshot.data!.docs;
          return Column(
            children: [
              
                  //back button
                const Padding(
                  padding: EdgeInsets.only(top: 50, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyBackButton(),
                    ],
                  ),
                ),
               

                // list of users in the app 



              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index){
                    final user = users[index];
                    // get data from each user
                    String username = user['username'];
                    String email = user['email'];
                    

                    return MyListTile(title: username, subtitle: email);
                  }
                ),
              ),
            ],
          );
        },
      )
    );
  }
}