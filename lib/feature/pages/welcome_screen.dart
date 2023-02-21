import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/forgot_password.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:flutter/material.dart';

class WelcomeScreenPage extends StatelessWidget {
  const WelcomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: topColor,
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Stack(children: [
                          Row(children: [
                            Container(
                              color: bottomColor,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                            Container(
                              color: topColor,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ]),
                          Column(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        color: topColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/f.png",
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Text(
                                          "Official mobile app for KSTU students",
                                          style: TextStyle(
                                              color: bottomColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: bottomColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 15.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          const LoginPage())));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: topColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Center(
                                                child: Text(
                                                  "Tap to Login in",
                                                  style: TextStyle(
                                                      color: bottomColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ForgotPasswordPage()));
                                            },
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: topColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Center(
                                                child: Text(
                                                  "Forgot Password?",
                                                  style: TextStyle(
                                                      color: bottomColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ]))))));
  }
}
