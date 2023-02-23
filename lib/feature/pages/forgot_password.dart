import 'package:first_app/feature/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _npasswordController = TextEditingController();

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
                                      InputFormFields(
                                        prefixIcon: Icons.lock,
                                        title: "Current Password",
                                        controller: _cpasswordController,
                                      ),
                                      InputFormFields(
                                        controller: _npasswordController,
                                        prefixIcon: Icons.lock,
                                        suffixIcon: Icons.visibility_off,
                                        suffixIcon2: Icons.visibility,
                                        title: "New Password",
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
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
                                                  fontWeight: FontWeight.bold),
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

class InputFormFields extends StatefulWidget {
  const InputFormFields({
    Key? key,
    required this.prefixIcon,
    this.suffixIcon,
    required this.title,
    this.suffixIcon2,
    required this.controller,
  }) : super(key: key);
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final String title;
  final TextEditingController controller;

  @override
  State<InputFormFields> createState() => _InputFormFieldsState();
}

class _InputFormFieldsState extends State<InputFormFields> {
  late bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          label: Text(widget.title),
          hintText: '',
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: IconButton(
            icon: Icon(isPassword ? widget.suffixIcon : widget.suffixIcon2),
            onPressed: () {
              setState(() {
                isPassword = !isPassword;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
