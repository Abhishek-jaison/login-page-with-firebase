import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USERS '),
      ),
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
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index){
              final user = users[index];
              return ListTile(
                title: Text(user['username']),
                subtitle: Text(user['email']),
              );
            }
          );
        },
      )
    );
  }
}