import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logging/Home.dart';
import 'package:logging/firebase_options.dart';
import 'login.dart';
import 'signup.dart';
import 'reset.dart';

void main() async {
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
      title: 'Welcome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => ShoeHomePage(),
        '/signup': (context) => SignupPage(),
        '/reset-password': (context) => ResetPasswordPage(),
      },
    );
  }
}
