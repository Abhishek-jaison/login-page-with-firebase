import 'package:flutter/material.dart';
import 'package:login_with_firebase/authendication/login_or_register.dart';
import 'package:login_with_firebase/theme/dark_theme.dart';
import 'package:login_with_firebase/theme/light_mode.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegister(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}