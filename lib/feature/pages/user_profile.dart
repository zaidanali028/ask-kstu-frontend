import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/update_profile.dart';
import 'package:first_app/models/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: topColor,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: topColor,
          icon: Icon(Icons.edit_location),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UpdateProfilePage()));
          },
          label: Text('Edit Profile')),
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
                        flex: 4,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: const BoxDecoration(
                              color: topColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
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
                                      "Profile",
                                      style: TextStyle(
                                          color: bottomColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 60,
                                      minRadius: 60,
                                      backgroundColor: bottomColor,
                                      backgroundImage: image != "1"
                                          ? NetworkImage(
                                              "${user_img_uri}${image}")
                                          : NetworkImage(
                                              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${name}",
                                      style: TextStyle(
                                          color: bottomColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${yearOfAdmission} - ${yearOfCompletion}",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: bottomColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: [
                                ProfileDetails(
                                  subtitle: "${name}",
                                  title: "Full Name",
                                ),
                                ProfileDetails(
                                  subtitle: "${index}",
                                  title: "Student Number",
                                ),
                                ProfileDetails(
                                  subtitle: "${gender}",
                                  title: "Gender",
                                ),
                                ProfileDetails(
                                  subtitle: "${email}",
                                  title: "Email",
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
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.isLast = false})
      : super(key: key);
  final String title;
  final String subtitle;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Spacer(),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        isLast
            ? Center()
            : const Divider(
                thickness: 1,
                color: Colors.grey,
              )
      ],
    );
  }
}
