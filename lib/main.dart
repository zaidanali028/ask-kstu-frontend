import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/forgot_password.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// zamaani
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ask-Kstu-App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreenPage(),
    );
  }
}
