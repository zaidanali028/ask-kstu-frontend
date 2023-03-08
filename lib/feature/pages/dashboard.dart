import 'dart:io';

import 'package:first_app/feature/pages/dashboard_drawer.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:first_app/feature/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var user;
  var email;
  var profileImage;
  var studentNumber;
  // File? _imageFile;
  // final _picker = ImagePicker();

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      user = await prefs.getString("name");
      studentNumber = await prefs.getString("studentNumber");
      profileImage = await prefs.getString("profileImage");
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                            color: topColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashboardDrawer()));
                                      },
                                      icon: const Icon(
                                        Icons.dashboard_rounded,
                                        color: bottomColor,
                                        size: 40,
                                      )),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${user}",
                                        style: TextStyle(
                                          color: bottomColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "${studentNumber}",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const HeadPicture()
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 50,
                        decoration: const BoxDecoration(
                            color: bottomColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30))),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                              child: Text(
                                "Notice Board",
                                style: TextStyle(color: topColor, fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 200,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Noticebordcard(
                                      background: const Color.fromARGB(
                                              255, 96, 198, 249)
                                          .withOpacity(0.2),
                                      imagepath:
                                          "assets/images/student_profile.jpeg",
                                      date: "02 march 2022",
                                      title:
                                          "The school is going for vacation in next month",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Noticebordcard(
                                      background:
                                          const Color.fromARGB(255, 241, 91, 11)
                                              .withOpacity(0.2),
                                      imagepath: "assets/images/f.png",
                                      date: "02 march 2022",
                                      title:
                                          "The school is going for vacation in next month",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Noticebordcard(
                                      background:
                                          const Color.fromARGB(255, 21, 237, 9)
                                              .withOpacity(0.2),
                                      imagepath:
                                          "assets/images/student_profile.jpeg",
                                      date: "02 march 2022",
                                      title:
                                          "The school is going for vacation in next month",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                "What's trending?",
                                style: TextStyle(color: topColor, fontSize: 25),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recievs Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recievs Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recievs Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recievs Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recievs Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recievs Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recievs Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        )));
  }
}

class TrendingNews extends StatelessWidget {
  const TrendingNews({
    Key? key,
    required this.title,
    required this.date,
    required this.imagePath,
  }) : super(key: key);

  final String title;
  final String date;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "Views",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "23",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class HeadPicture extends StatelessWidget {
  const HeadPicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserProfilePage()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: const [
            CircleAvatar(
              maxRadius: 24,
              minRadius: 24,
              backgroundColor: bottomColor,
              backgroundImage: AssetImage("assets/images/student_profile.jpeg"),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: CircleAvatar(
                minRadius: 7,
                maxRadius: 7,
                backgroundColor: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeworkCard extends StatelessWidget {
  const HomeworkCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icons,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    icons,
                    size: 40,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 10,),
                      Text(
                        title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        subtitle,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Noticebordcard extends StatelessWidget {
  const Noticebordcard({
    Key? key,
    required this.background,
    required this.imagepath,
    required this.title,
    required this.date,
  }) : super(key: key);
  final Color background;
  final String imagepath;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 100,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imagepath), fit: BoxFit.fill),
                  color: topColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
