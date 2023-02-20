// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/drawer.dart';
import 'package:first_app/feature/pages/userwithout_login.dart';
import 'package:first_app/glassmorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              color: kblue,
              image: DecorationImage(
                  image: AssetImage("assets/images/nature.jpg"),
                  fit: BoxFit.cover)),
          child: CustomGlassmorphicContainer(
            width: size.width,
            height: size.height,
            child: SafeArea(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Home",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => Get.to(const DrawerPage()),
                              icon: const Icon(
                                Icons.line_weight_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomGlassmorphicContainer(
                            width: double.infinity,
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Good Morning, ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "Saani Xamani",
                                      style: TextStyle(
                                          color: kpink,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    CustomGlassmorphicContainer(
                                      child: Center(
                                        child: Text(
                                          "2022-2023",
                                          style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      width: 150,
                                      height: 30,
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyProfile()));
                                  },
                                  child: const CircleAvatar(
                                    maxRadius: 50,
                                    minRadius: 50,
                                    backgroundImage: AssetImage(
                                      "assets/images/student_profile.jpeg",
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "What will you like to do?",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomGlassmorphicContainer(
                                width: 110,
                                height: 95,
                                borderRadius: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.dashboard,
                                        color: kpink,
                                        size: 30,
                                      ),
                                      Text(
                                        "Check\nResults",
                                        style: TextStyle(
                                            color: kpink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                )),
                            CustomGlassmorphicContainer(
                                width: 110,
                                height: 95,
                                borderRadius: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.radio,
                                        color: kpink,
                                        size: 30,
                                      ),
                                      Text(
                                        "Pay\nFees",
                                        style: TextStyle(
                                            color: kpink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                )),
                            CustomGlassmorphicContainer(
                                width: 110,
                                height: 95,
                                borderRadius: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.calendar_month,
                                        color: kpink,
                                        size: 30,
                                      ),
                                      Text(
                                        "Register\nCourses",
                                        style: TextStyle(
                                            color: kpink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "What's trending",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomGlassmorphicContainer(
                          height: 230,
                          width: double.infinity,
                          borderRadius: 10,
                          child: SizedBox(
                            height: 230,
                            width: double.infinity,
                            child: Carousel(
                              images: [
                                Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      "assets/images/image1.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      child: Text(
                                        "Image One SLider description bla bla",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      bottom: 50,
                                    )
                                  ],
                                ),
                                Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      "assets/images/image2.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      child: Text(
                                        "Image Two SLider description bla bla",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      bottom: 50,
                                    )
                                  ],
                                ),
                                Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      "assets/images/image3.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      child: Text(
                                        "Image Three SLider description bla bla",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      bottom: 50,
                                    )
                                  ],
                                ),
                                Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      "assets/images/image4.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      child: Text(
                                        "Image Four SLider description bla bla",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      bottom: 50,
                                    )
                                  ],
                                ),
                                Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      "assets/images/image5.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                    const Positioned(
                                      // ignore: sort_child_properties_last
                                      child: Text(
                                        "Image Five SLider description bla bla",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      bottom: 50,
                                    )
                                  ],
                                ),
                              ],
                              dotSize: 8.0,
                              dotSpacing: 15.0,
                              dotColor: Colors.lightGreenAccent,
                              indicatorBgPadding: 5.0,
                              dotBgColor: Colors.black.withOpacity(0.5),
                              borderRadius: true,
                              animationCurve: Curves.easeIn,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "Today's Date",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomGlassmorphicContainer(
                            width: double.infinity,
                            height: 100,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: kpink,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10))),
                                      width: 150,
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          "Mon\n06",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: kpink,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      width: 150,
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          "12:00\nPM",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
