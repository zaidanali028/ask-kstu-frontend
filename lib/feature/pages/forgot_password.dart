import 'package:connectivity/connectivity.dart';
import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/models/api_response.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool loading = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _forgotPassword() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    ApiResponse response = await forgotPassword(_emailController.text);
    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Delivered new password to your phone number'),
        backgroundColor: topColor,
        behavior: SnackBarBehavior.floating,
        elevation: 2.0,
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    } else {
      // print(jsonEncode(response.data));
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
        backgroundColor: Colors.red.shade700,
        elevation: 2.0,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              contentPadding:
                                                  EdgeInsets.all(10),
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
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                                _forgotPassword();
                                              });
                                            }
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
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: loading
                                                    ? CircularProgressIndicator()
                                                    : Text(
                                                        "Forgot Password",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
          )),
    );
  }
}
