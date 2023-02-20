import 'package:first_app/feature/pages/home_page.dart';
import 'package:first_app/feature/pages/login_page.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home ,ok oo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double fullScreenHeight = MediaQuery.of(context).size.height;

    const topColor = Color(0xFF4E489C);

    return Scaffold(
        // backgroundColor: Colors.red,
        resizeToAvoidBottomInset: false,
        backgroundColor: topColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(height: fullScreenHeight, child: LoginPage()),
            ),
          ),
        ) // This traili ng comma makes auto-formatting nicer for build methods.
        );
  }
}
// ignore: file_names
// ignore_for_file: file_names

