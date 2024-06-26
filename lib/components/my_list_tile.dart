import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const MyListTile({super.key,
  required this.title,
  required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return 
    
    
       Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: ListTile(
                              title: Text(title),
                              subtitle: Text(subtitle,
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                            ),
                          ),
                        );
    
  }
}