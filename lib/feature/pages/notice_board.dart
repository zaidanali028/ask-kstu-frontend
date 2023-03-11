import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeBoardPage extends StatefulWidget {
  const NoticeBoardPage({super.key});

  @override
  State<NoticeBoardPage> createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage> {
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
                                      Icons.arrow_back,
                                      color: bottomColor,
                                      size: 25,
                                    ),
                                  ),
                                  const Text(
                                    "Notice Board",
                                    style: TextStyle(
                                        color: bottomColor, fontSize: 25),
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
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 180,
                                          child: Noticebordcard(
                                            background:
                                                const Color.fromARGB(255, 21, 237, 9)
                                                    .withOpacity(0.2),
                                            imagepath:
                                                "assets/images/student_profile.jpeg",
                                            date: "02 march 2022",
                                            title:
                                                "The school is going for vacation in next month",
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: 180,
                                          child: Noticebordcard(
                                            background:
                                                Color.fromARGB(255, 53, 62, 37)
                                                    .withOpacity(0.2),
                                            imagepath:
                                                "assets/images/f.png",
                                            date: "02 march 2022",
                                            title:
                                                "The school is going for vacation in next month",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 180,
                                          child: Noticebordcard(
                                            background:
                                                Color.fromARGB(255, 53, 62, 37)
                                                    .withOpacity(0.2),
                                            imagepath:
                                                "assets/images/f.png",
                                            date: "02 march 2022",
                                            title:
                                                "The school is going for vacation in next month",
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: 180,
                                          child: Noticebordcard(
                                            background:
                                                const Color.fromARGB(255, 21, 237, 9)
                                                    .withOpacity(0.2),
                                            imagepath:
                                                "assets/images/student_profile.jpeg",
                                            date: "02 march 2022",
                                            title:
                                                "The school is going for vacation in next month",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 180,
                                          child: Noticebordcard(
                                            background:
                                                const Color.fromARGB(255, 21, 237, 9)
                                                    .withOpacity(0.2),
                                            imagepath:
                                                "assets/images/student_profile.jpeg",
                                            date: "02 march 2022",
                                            title:
                                                "The school is going for vacation in next month",
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: 180,
                                          child: Noticebordcard(
                                            background:
                                                Color.fromARGB(255, 53, 62, 37)
                                                    .withOpacity(0.2),
                                            imagepath:
                                                "assets/images/f.png",
                                            date: "02 march 2022",
                                            title:
                                                "The school is going for vacation in next month",
                                          ),
                                        ),
                                      ],
                                    ),
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
      width: 180,
      height: 200,
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
              height: 100,
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
              height: 16,
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
