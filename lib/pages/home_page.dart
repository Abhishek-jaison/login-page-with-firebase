import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/components/my_drawer.dart';
import 'package:login_with_firebase/components/my_list_tile.dart';
import 'package:login_with_firebase/components/my_post_button.dart';
import 'package:login_with_firebase/components/my_text_field.dart';
import 'package:login_with_firebase/database/firestore.dart';

class HomePage extends StatelessWidget {
  // Text controller
  final TextEditingController newPostController = TextEditingController();

  // Firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // Post message
  void postMessage() {
    // Only post message if there is something in the text field
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    // Clear controller
    newPostController.clear();
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('W A L L'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Text box for user to type
            Row(
              children: [
                // Text field
                Expanded(
                  child: MyTextField(
                    hintText: 'Say something...',
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                // Post button
                PostButton(ontap: postMessage),
              ],
            ),
            // Display posts
            Expanded(
              child: StreamBuilder(
                stream: database.getPostsStream(),
                builder: (context, snapshot) {
                  // Show loading circle
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Get all posts
                  final posts = snapshot.data?.docs ?? [];

                  // No data
                  if (posts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text('No posts... Post something'),
                      ),
                    );
                  }

                  // Return as a list
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // Get each individual post
                      final post = posts[index];

                      // Get data from each post
                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];

                      // Return a list tile
                      return MyListTile(title: message, subtitle: userEmail); 
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
