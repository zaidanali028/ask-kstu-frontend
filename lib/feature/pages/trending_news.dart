import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:flutter/material.dart';

class TrendingNewsPage extends StatefulWidget {
  const TrendingNewsPage({super.key});

  @override
  State<TrendingNewsPage> createState() => _TrendingNewsPageState();
}

class _TrendingNewsPageState extends State<TrendingNewsPage> {
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
                                    "Trending News",
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
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recieves Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recieves Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recieves Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                            TrendingNews(
                                title:
                                    "KSTU Vice-Chancellor Recieves Heartfelt Gifts from GhanaPost.",
                                date: "21 Feb 2023",
                                imagePath:
                                    "assets/images/student_profile.jpeg"),
                                  
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
