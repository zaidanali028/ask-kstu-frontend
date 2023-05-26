import 'dart:convert';
import 'dart:io';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/user_service.dart';
import 'package:path/path.dart' as path;
import 'package:first_app/feature/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/api_response.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var name;
  var index;
  var yearOfCompletion;
  var yearOfAdmission;
  var email;
  var gender;
  var semester;
  var level;
  var image;
  var faculty;
  var department;
  var program;
  final picker = ImagePicker();
  File? pickimage;
  String? imageConvert;
  void getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      email = localStorage.getString('email');
      yearOfCompletion = localStorage.getString('yrOfCompletion');
      yearOfAdmission = localStorage.getString('yrOfAdmission');
      gender = localStorage.getString('gender');
      image = localStorage.getString('image');
      index = localStorage.getInt('index');
      semester = localStorage.getString('semester');
      level = localStorage.getString('level');
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String extension = path.basename(pickedFile.path);
      setState(() {
        pickimage = File(pickedFile.path);
        imageConvert = extension;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No image picked'),
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
  }

  bool loading = false;

  void updateUserProfiles() async {
    ApiResponse response = await updateUserProfile(imageConvert);
    if (response.error == null) {
      _saveupdatedProfile(response.data as User);
    } else {
      print(jsonEncode(response.data));
      setState(() {
        loading = !loading;
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

  void _saveupdatedProfile(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_img", user.image ?? '');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => UserProfilePage()),
        (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Profile Successfully Updated'),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: topColor,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
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
                        child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                          color: topColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => UserProfilePage()),
                                      (route) => false);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: bottomColor,
                                  size: 25,
                                ),
                              ),
                              const Text(
                                "Update Profile",
                                style: TextStyle(
                                    color: bottomColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ]),
                      ),
                    )),
                    Expanded(
                        flex: 10,
                        child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: bottomColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30))),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 18.0),
                                child: Form(
                                  child: ListView(
                                    physics: BouncingScrollPhysics(),
                                    children: [
                                      Column(
                                        children: [
                                          Stack(
                                            children: [
                                              pickimage == null
                                                  ? Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: bottomColor,
                                                          image: DecorationImage(
                                                              image: image !=
                                                                      '1'
                                                                  ? NetworkImage(
                                                                      image)
                                                                  : NetworkImage(
                                                                      "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    )
                                                  : Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: bottomColor,
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  pickimage!),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                              Positioned(
                                                  right: 5,
                                                  bottom: 10,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        pickImage();
                                                      },
                                                      icon: Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.black87,
                                                        size: 50,
                                                      )))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormFields(
                                          title: Text(name),
                                          icons: Icon(Icons.person)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text(email),
                                          icons: Icon(Icons.mail)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text('${index}'),
                                          icons: Icon(Icons.numbers)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text(gender),
                                          icons: Icon(Icons.generating_tokens)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text('Level $level'),
                                          icons:
                                              Icon(Icons.leave_bags_at_home)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text('$semester'),
                                          icons: Icon(Icons.set_meal)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text('$yearOfAdmission'),
                                          icons:
                                              Icon(Icons.youtube_searched_for)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text('$yearOfCompletion'),
                                          icons:
                                              Icon(Icons.currency_yen_sharp)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ))))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: topColor,
          icon: Icon(Icons.send),
          onPressed: () async {
            setState(() {
              loading = !loading;
              updateUserProfiles();
            });
            print('Image string: $imageConvert');
            print('Hello Wordl');
          },
          label: loading ? CircularProgressIndicator() : Text('Update')),
    );
  }
}

// ignore: must_be_immutable
class TextFormFields extends StatelessWidget {
  TextFormFields({super.key, required this.title, required this.icons});
  Text title;
  Icon icons;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        label: title,
        prefixIcon: icons,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
