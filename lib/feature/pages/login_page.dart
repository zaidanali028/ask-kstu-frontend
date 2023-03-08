import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/models/api_response.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool ispassword = true;
  bool _loading = false;

  void loginUser() async {
    ApiResponse res =
        await login(_emailController.text, _passwordController.text);
    if (res.error == null) {
      _saveAndRedirectToDashboard(res.data as User);
      print(res.data);
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${res.error}')));
    }
  }

  void _saveAndRedirectToDashboard(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setStringList('name', [user.name ?? '']);
    await pref.setString('email', user.email ?? '');
    await pref.setString('studentNumber', user.student_number ?? '');
    await pref.setString('profileImage', user.profileImage ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
  }

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
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: _emailController,
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 10),
                                          child: TextFormField(
                                            validator: ((value) {
                                              if (value!.isEmpty) {
                                                return "Password field is required";
                                              }
                                              return null;
                                            }),
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            controller: _passwordController,
                                            obscureText: ispassword,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              label: Text("Password"),
                                              hintText: '',
                                              prefixIcon: Icon(Icons.lock),
                                              suffixIcon: IconButton(
                                                icon: Icon(ispassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility),
                                                onPressed: () {
                                                  setState(() {
                                                    ispassword = !ispassword;
                                                  });
                                                },
                                              ),
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  _loading = true;
                                                  loginUser();
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: topColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: _loading
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Colors
                                                                    .white,
                                                                backgroundColor:
                                                                    topColor),
                                                      )
                                                    : Text(
                                                        "Login",
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
