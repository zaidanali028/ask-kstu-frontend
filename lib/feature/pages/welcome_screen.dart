// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/glassmorphic_container.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: kblue,
            image: DecorationImage(
                image: AssetImage("assets/images/nature.jpg"),
                fit: BoxFit.cover)),
        child: CustomGlassmorphicContainer(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomGlassmorphicContainer(
                  width: double.infinity,
                  height: 350,
                  child: Column(
                    children: [Image.asset("assets/images/splash.png")],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => LoginPage())));
                  },
                  child: CustomGlassmorphicContainer(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
