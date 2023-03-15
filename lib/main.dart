import 'package:first_app/feature/pages/loading.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( const MyApp());
}
// zamaani
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ask-Kstu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 16),
          bodyText2: TextStyle(fontSize: 14),
        )
      ),
      
      home:  LoadingPage(),
    );
  }
}
