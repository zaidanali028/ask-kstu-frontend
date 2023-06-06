import 'dart:convert';
import 'dart:io';
import 'package:first_app/feature/pages/profile_details.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:first_app/feature/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/constant.dart';
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
  var phone;
  final picker = ImagePicker();
  File? pickimage;
  late String pickimagePath;

  String? imageConvert;
  late PickedFile imageFile_;
  final ImagePicker picker_ = ImagePicker();

  void getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      email = localStorage.getString('email');
      yearOfCompletion = localStorage.getString('yrOfCompletion');
      yearOfAdmission = localStorage.getString('yrOfAdmission');
      gender = localStorage.getString('gender');
      phone = localStorage.getString('phone');
      image = localStorage.getString('user_img');
      index = localStorage.getInt('index');
      semester = localStorage.getInt('semester');
      level = localStorage.getString('level');
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }
  //   void takePhoto(ImageSource src) async {
  //   final pickedFile =await picker_.pickImage(source: src);
  //   setState(() {
  //     imageFile_ = pickedFile;
  //   });
  // }

  void pickImage(ImageSource src) async {
    var pickedFile = await picker.pickImage(source: src);
    if (pickedFile != null) {
      // String extension = path.basename(pickedFile.path);
      setState(() {
        pickimagePath = pickedFile.path;
        pickimage = File(pickimagePath);

        // print( pickimage);
        // imageConvert = extension;
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
  Widget bottomSheet() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(40),
          left: Radius.circular(40),
        )
      ),
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: [
        Text("Choose Profile Photo", style: TextStyle(fontSize: 20.0)),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                pickImage(ImageSource.camera);
              },
              child: FaIcon(
                FontAwesomeIcons.camera,

                // color: Colors.grey,
              ),
            ),
            InkWell(
              onTap: () {
                pickImage(ImageSource.gallery);
              },
              child: FaIcon(
                FontAwesomeIcons.image,
                // color: Colors.grey,
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget ImgProfile() {
    return Center(
      child: Stack(children: [
        (pickimage != null)
            ? CircleAvatar(
                radius: 80.0,
                backgroundImage: FileImage(pickimage!),
              )
            : image != '1'
                ? CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage("${user_img_uri}${image}"),
                  )
                : CircleAvatar(
                    radius: 80.0,
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                  ),
        Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: (builder) => bottomSheet());
                },
                child: Icon(Icons.camera_alt, color: Colors.white, size: 30.0)))
      ]),
    );
  }

  void _saveupdatedProfile() async {
    var user = await getUserDetails();
    User userData = user.data as User;
    print('is it working? ${userData.userImg}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_img", userData.userImg ?? '');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Profile Successfully Updated'),
      backgroundColor: topColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.green,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => UserProfilePage()),
        (route) => false);
  }

  void updateUserProfiles() async {
    var response = await updateUserProfile(pickimagePath);
    // print('Here> '+response.stream.toString());
    if (response.statusCode == 200) {
      // _saveupdatedProfile();
      setState(() {
        loading = !loading;
      });

      _saveupdatedProfile();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error Uploading Profile Image!'),
        backgroundColor: topColor,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.red,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    }
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
                                          builder: (context) =>
                                              UserProfilePage()),
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
                                              // pickimage == null
                                              //     ? Container(
                                              //         width: 200,
                                              //         height: 200,
                                              //         decoration: BoxDecoration(
                                              //             borderRadius:
                                              //                 BorderRadius
                                              //                     .circular(20),
                                              //             color: bottomColor,
                                              //             image: DecorationImage(
                                              //                 image: image !=
                                              //                         '1'
                                              //                     ? NetworkImage(
                                              //                         image)
                                              //                     : NetworkImage(
                                              //                         "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                              //                 fit: BoxFit
                                              //                     .cover)),
                                              //       )
                                              //     : Container(
                                              //         width: 200,
                                              //         height: 200,
                                              //         // decoration: BoxDecoration(
                                              //         //     borderRadius:
                                              //         //         BorderRadius
                                              //         //             .circular(20),
                                              //         //     color: bottomColor,
                                              //         //     image: DecorationImage(
                                              //         //         image: FileImage(
                                              //         //             pickimage!),
                                              //         //         fit: BoxFit
                                              //         //             .cover)),
                                              //       ),
                                              // // Positioned(
                                              // //     right: 5,
                                              // //     bottom: 10,
                                              // //     child: IconButton(
                                              // //         onPressed: () {
                                              // //           pickImage();
                                              // //         },
                                              // //         icon: Icon(
                                              // //           CupertinoIcons.photo,
                                              // //           color: Colors.black87,
                                              // //           size: 40,
                                              // //         )))
                                              ImgProfile()
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ProfileDetails(
                                        subtitle: "${name}",
                                        title: "Full Name",
                                      ),
                                      ProfileDetails(
                                        subtitle: "${email}",
                                        title: "Student Email",
                                      ),
                                      ProfileDetails(
                                        subtitle: "${index}",
                                        title: "Student Number",
                                      ),
                                      ProfileDetails(
                                        subtitle: "${phone}",
                                        title: "Phone Number",
                                      ),
                                      ProfileDetails(
                                        subtitle: "${gender}",
                                        title: "Gender",
                                      ),
                                      ProfileDetails(
                                        subtitle: "${level}",
                                        title: "Level",
                                      ),
                                      ProfileDetails(
                                        subtitle: '${semester}',
                                        title: "Semester",
                                      ),
                                      ProfileDetails(
                                        subtitle: '${yearOfAdmission}',
                                        title: "Year Of Admission",
                                      ),
                                      ProfileDetails(
                                        subtitle: '${yearOfCompletion}',
                                        title: "Year Of Completion",
                                        isLast: true,
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
          },
          label: loading
              ? SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? bottomColor : bottomColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                  size: 40,
                )
              : Text('Update')),
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
