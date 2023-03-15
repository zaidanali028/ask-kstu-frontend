import 'package:first_app/feature/colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: topColor,
        resizeToAvoidBottomInset: false,
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
                                flex: 4,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      color: topColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Image.asset(
                                          "assets/images/f.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      const Text(
                                        "Forgot Password",
                                        style: TextStyle(
                                            color: bottomColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: bottomColor,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30))),
                                  child: Form(
                                    key: formkey,
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 10),
                                        child: TextFormField(
                                          validator: ((value) {
                                            if (value!.isEmpty) {
                                              return "Email field is required";
                                            }
                                            return null;
                                          }),
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            label: Text("Email"),
                                            hintText: '',
                                            prefixIcon: Icon(Icons.email),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (formkey.currentState!
                                              .validate()) {}
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: topColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: Text(
                                                "Forgot Password",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ))
                          ],
                        )
                      ])))),
        ));
  }
}
