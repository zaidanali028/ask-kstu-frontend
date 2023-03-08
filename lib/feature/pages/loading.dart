import 'dart:async';

import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void _loadUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomeScreenPage()),
          (route) => false);
    }
    // String token = await getToken();
    // if (token == '') {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => WelcomeScreenPage()),
    //       (route) => false);
    // } else {
    //   Future<User>? _fetchUser = getUserDetail();
    //   if (_fetchUser == null) {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => WelcomeScreenPage()),
    //         (route) => false);
    //   } else {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => Dashboard()),
    //         (route) => false);
    //   }
    // }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), _loadUserInfo);
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 7), () {
    //   _loadUserInfo();
    // });
    return Scaffold(
        backgroundColor: topColor,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: topColor,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/f.png"),
                            fit: BoxFit.contain)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Academic Students Knowledgebase App",
                    style: TextStyle(
                        color: bottomColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
