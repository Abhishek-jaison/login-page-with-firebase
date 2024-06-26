import 'package:flutter/material.dart';
import 'package:login_with_firebase/authendication/auth.dart';
import 'package:login_with_firebase/authendication/login_or_register.dart';
import 'package:login_with_firebase/pages/home_page.dart';
import 'package:login_with_firebase/pages/profile_page.dart';
import 'package:login_with_firebase/pages/users_page.dart';
import 'package:login_with_firebase/theme/dark_theme.dart';
import 'package:login_with_firebase/theme/light_mode.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        'login_register_page':(context) => const LoginOrRegister(),
        '/home_page': (context) =>  HomePage(),
        '/profile_page' :(context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}