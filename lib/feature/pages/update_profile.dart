// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var pickimage;
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
      department = localStorage.getString('department');
      program = localStorage.getString('program');
      faculty = localStorage.getString('faculty');
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
    setState(() {
      pickimage = File(pickedFile!.path);
    });
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
                        flex: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: const BoxDecoration(
                              color: topColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: Column(children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Dashboard()),
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
                        flex: 7,
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
                                                  ? CircleAvatar(
                                                      maxRadius: 80,
                                                      minRadius: 80,
                                                      backgroundColor: topColor,
                                                      backgroundImage:
                                                          NetworkImage(image),
                                                    )
                                                  : CircleAvatar(
                                                      maxRadius: 80,
                                                      minRadius: 80,
                                                      backgroundColor: topColor,
                                                      child: Image.file(
                                                        pickimage,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                              Positioned(
                                                  right: 10,
                                                  bottom: 10,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        pickImage();
                                                      },
                                                      icon: Icon(
                                                        Icons.camera_alt,
                                                        color: topColor,
                                                        size: 45,
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
                                          title: Text(department),
                                          icons: Icon(Icons.scale)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text(program),
                                          icons: Icon(Icons.propane)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text(faculty),
                                          icons: Icon(Icons.face_sharp)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text(level),
                                          icons:
                                              Icon(Icons.leave_bags_at_home)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormFields(
                                          title: Text(semester),
                                          icons: Icon(Icons.set_meal)),
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
          onPressed: () {
            print('Hello Wordl');
          },
          label: Text('Update')),
    );
  }
}

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
