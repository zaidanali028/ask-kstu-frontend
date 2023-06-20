import 'package:first_app/components/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                        // flex: 1,
                        child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                          color: topColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Column(children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()),
                                      (route) => false);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: bottomColor,
                                  size: 25,
                                ),
                              ),
                              const Text(
                                "About Our Application",
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
                                  horizontal: 8.0, vertical: 10),
                              child: ListView(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomCarouselSlider(
                                    animationDuration:
                                        Duration(milliseconds: 1000),
                                    items: [
                                      CarouselItem(
                                          image: AssetImage(
                                              "assets/images/about-2.jpg"),
                                          boxDecoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .bottomCenter,
                                                  end: FractionalOffset
                                                      .topCenter,
                                                  colors: [
                                                Colors.black.withOpacity(.3),
                                                Colors.black.withOpacity(.3)
                                              ],
                                                  stops: const [
                                                0.0,
                                                1.0
                                              ])),
                                          title:
                                              "Push your gravity to its limits by reimaging this classic puzzle",
                                          titleTextStyle: TextStyle(
                                              fontSize: 14,
                                              color: bottomColor,
                                              fontWeight: FontWeight.bold),
                                          leftSubtitle: "12/02/2023",
                                          leftSubtitleTextStyle: TextStyle(
                                              fontSize: 13,
                                              color: bottomColor)),
                                      CarouselItem(
                                          image: AssetImage(
                                              "assets/images/package-1.jpg"),
                                          boxDecoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .bottomCenter,
                                                  end: FractionalOffset
                                                      .topCenter,
                                                  colors: [
                                                Colors.black.withOpacity(.3),
                                                Colors.black.withOpacity(.3)
                                              ],
                                                  stops: const [
                                                0.0,
                                                1.0
                                              ])),
                                          title:
                                              "Push your gravity to its limits by reimaging this classic puzzle",
                                          titleTextStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                          leftSubtitle: "12/02/2023",
                                          leftSubtitleTextStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                      CarouselItem(
                                          image: AssetImage(
                                              "assets/images/package-2.jpg"),
                                          boxDecoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .bottomCenter,
                                                  end: FractionalOffset
                                                      .topCenter,
                                                  colors: [
                                                Colors.black.withOpacity(.3),
                                                Colors.black.withOpacity(.3)
                                              ],
                                                  stops: const [
                                                0.0,
                                                1.0
                                              ])),
                                          title:
                                              "Push your gravity to its limits by reimaging this classic puzzle",
                                          titleTextStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                          leftSubtitle: "12/02/2023",
                                          leftSubtitleTextStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                      CarouselItem(
                                          image: AssetImage(
                                              "assets/images/package-3.jpg"),
                                          boxDecoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .bottomCenter,
                                                  end: FractionalOffset
                                                      .topCenter,
                                                  colors: [
                                                Colors.black.withOpacity(.3),
                                                Colors.black.withOpacity(.3)
                                              ],
                                                  stops: const [
                                                0.0,
                                                1.0
                                              ])),
                                          title:
                                              "Push your gravity to its limits by reimaging this classic puzzle",
                                          titleTextStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                          leftSubtitle: "12/02/2023",
                                          leftSubtitleTextStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ],
                                    height: 230,
                                    subHeight: 60,
                                    width: MediaQuery.of(context).size.width,
                                    autoplay: true,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Our SRC-KsTu 23 Student Online Noticeboard is a dedicated platform designed exclusively for students of Kumasi Technical University (KsTU). Here, we aim to provide a centralized hub for students to stay informed, connected, and engaged within the university community.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "At KsTU, we understand the importance of timely and accurate informartion for students. That's we have developed this platform to ensure thatyou never miss out on any crucial announcements, events, opportunities, or updates related to your academic journey.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Official Announcements: Stay up-to-date with all official announcements from the university administration. From academic calendar changes and registration procedures to examination schedules and campus-wide updates, you can rely on our notice board to keep you informed about important university matters.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Feedback and Suggestions: We value your inout and strive to continuously improve our platform. If you have any feedback, suggestions or questions, please feel free to reach out to us. We are committed to enhancing that the notcie board meets your needs.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Join the SRC-KsTU 23 Student Online Notice Board today and empower yourself with the knowledge and opportunities that await you within our vibrant university community. Remember to bookmark our page, set up notifications, and check back regularly to stay informed.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "If you require any assistance or have inquiries, our support team is here to help. We are dedicated to providing you with the best possible experience.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Thank you for choosing the KsTU Student Online Notice Board. Together, let's make your academic journey at KsTUeven more enriching and fulfilling.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            )))
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
