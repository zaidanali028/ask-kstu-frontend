import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/models/api_response.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

// 052141350070  SHANI IDDI
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool ispassword = true;
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loginUser() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    ApiResponse response =
        await login(emailController.text, passwordController.text);
    if (response.error == null) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        _saveAndRedirectToDashboard(response.data as User);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please connect to the internet'),
          backgroundColor: Colors.red.shade700,
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
      }
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

  void _saveAndRedirectToDashboard(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", user.token ?? '');
    await prefs.setString("name", user.name ?? '');
    await prefs.setInt("index", user.indexNo ?? 0);
    await prefs.setString("gender", user.gender ?? '');
    await prefs.setString("phone", user.phone ?? '');
    await prefs.setString("level", user.currentLevel ?? '');
    await prefs.setInt("semester", user.currentSemester ?? 0);
    await prefs.setInt("program", user.programId ?? 0);
    await prefs.setInt("department", user.deptId ?? 0);
    await prefs.setInt("faculty", user.facultyId ?? 0);
    await prefs.setString("email", user.email ?? '');
    await prefs.setString("image", user.image ?? '');
    await prefs.setString("yrOfAdmission", user.yrOfAdmission ?? '');
    await prefs.setString("yrOfCompletion", user.yrOfCompletion ?? '');
    await prefs.setInt("userId", user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
    var name = await prefs.getString('name');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Welcome, ${name}'),
      backgroundColor: topColor,
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
                                            controller: emailController,
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
                                            controller: passwordController,
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
                                                  loading = true;
                                                  _loginUser();
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
                                                child: loading
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Colors
                                                                    .white,
                                                                backgroundColor:
                                                                    topColor),
                                                      )
                                                    : Text(
                                                        "SIGN IN",
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
