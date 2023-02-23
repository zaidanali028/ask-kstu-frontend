import 'package:first_app/feature/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                                        "SIGN IN",
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
                                      EmailFields(),
                                      PasswordFields(),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (formkey.currentState!
                                                .validate()) {}
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: topColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: Text(
                                                "Login",
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

class EmailFields extends StatefulWidget {
  EmailFields({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailFields> createState() => _EmailFieldsState();
}

class _EmailFieldsState extends State<EmailFields> {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: TextFormField(
        validator: ((value) {
          if (value!.isEmpty) {
            return "Email field is required";
          }
          return null;
        }),
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        decoration: InputDecoration(
          label: Text("Email"),
          hintText: '',
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

class PasswordFields extends StatefulWidget {
  PasswordFields({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordFields> createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  bool ispassword = true;
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: TextFormField(
        validator:  ((value) {
          if (value!.isEmpty) {
            return "Password field is required";
          }
          return null;
        }),
        keyboardType: TextInputType.emailAddress,
        controller: _passwordController,
        obscureText: ispassword,
        decoration: InputDecoration(
          label: Text("Password"),
          hintText: '',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(ispassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                ispassword = !ispassword;
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
