import 'dart:convert';

import 'package:first_app/feature/pages/dashboard_drawer.dart';
import 'package:first_app/feature/pages/news_details.dart';
import 'package:first_app/feature/pages/notice_board_shimmer.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/notice_board.dart';
import 'package:flutter/material.dart';
import 'package:first_app/feature/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var name;
  var index;
  var image;
  var id;

  void getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      index = localStorage.getInt('index');
      image = localStorage.getString('image');
      id = localStorage.getInt('id');
    });
  }

  Future<void> likeAnnouncement(int category_id, int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(
        Uri.parse(likesUrl + '/' + '${category_id}' + '/' + '${status}'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${data['message']}"),
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${jsonDecode(response.body)['message']}"),
        backgroundColor: Colors.red,
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

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noticeProvider =
        Provider.of<NoticeBoardProvider>(context, listen: false);
    final trendProvider =
        Provider.of<TrendingNewsProvider>(context, listen: false);
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
                                        Icons.menu,
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
                                        "${name}",
                                        style: TextStyle(
                                            color: bottomColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${index}",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserProfilePage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 24,
                                        minRadius: 24,
                                        backgroundColor: bottomColor,
                                        backgroundImage:
                                            NetworkImage("${image}"),
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
                              )
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
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                              child: Text(
                                "Notice Board",
                                style: TextStyle(
                                    color: topColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            FutureBuilder<List<Announcement>>(
                              future: noticeProvider.fetchNotice(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                          height: 243,
                                          child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                NoticeBoardShimmer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                NoticeBoardShimmer(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                NoticeBoardShimmer(),
                                              ])));
                                } else if (snapshot.hasError) {
                                  // logout().then((value) => {
                                  //       Navigator.of(context)
                                  //           .pushAndRemoveUntil(
                                  //               MaterialPageRoute(
                                  //                   builder: (context) =>
                                  //                       LoginPage()),
                                  //               (route) => false)
                                  //     });
                                  print(snapshot.error);
                                  return Text('${snapshot.error}');
                                } else {
                                  final noticeboard = snapshot.data!;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Container(
                                      height: 243,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: noticeboard.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          DetailNews(
                                                              title:
                                                                  noticeboard[
                                                                          index]
                                                                      .id))));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Container(
                                                width: 160,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    color: topColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 120,
                                                        decoration: BoxDecoration(
                                                            image: noticeboard[
                                                                            index]
                                                                        .featuredImage !=
                                                                    null
                                                                ? DecorationImage(
                                                                    image: NetworkImage(
                                                                        "${noticeboard[index].featuredImage}"),
                                                                    fit: BoxFit
                                                                        .fill)
                                                                : DecorationImage(
                                                                    image: NetworkImage(
                                                                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                                                    fit: BoxFit
                                                                        .fill),
                                                            color: topColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "${noticeboard[index].title.trim()}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.5),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "${DateTime.parse(noticeboard[index].createdAt)}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade300,
                                                            fontSize: 15),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              child: Text(
                                "What's trending?",
                                style: TextStyle(
                                    color: topColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                              future: trendProvider.fetchTrend(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    height: 300,
                                    width: double.infinity,
                                    child: ListView(
                                      children: [
                                        TrendingShimmer(),
                                        TrendingShimmer(),
                                        TrendingShimmer(),
                                        TrendingShimmer(),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  // logout().then((value) => {
                                  //       Navigator.of(context)
                                  //           .pushAndRemoveUntil(
                                  //               MaterialPageRoute(
                                  //                   builder: (context) =>
                                  //                       LoginPage()),
                                  //               (route) => false)
                                  //     });
                                  return Text('${snapshot.error}');
                                } else {
                                  final trend = snapshot.data!;
                                  return Container(
                                    height: 530,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: trend.length,
                                      itemBuilder: ((context, index) {
                                        return Container(
                                          width: double.infinity,
                                          height: 320,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                DetailNews(
                                                                    title: trend[
                                                                            index]
                                                                        .id))));
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: trend[index]
                                                                    .featuredImage !=
                                                                null
                                                            ? DecorationImage(
                                                                image: NetworkImage(
                                                                    trend[index]
                                                                        .featuredImage),
                                                                fit: BoxFit
                                                                    .cover)
                                                            : null),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                DetailNews(
                                                                    title: trend[
                                                                            index]
                                                                        .id))));
                                                  },
                                                  child: Text(
                                                    trend[index].title.trim(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.alarm,
                                                            color: Colors.grey,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            width: 80,
                                                            child: Text(
                                                              trend[index]
                                                                  .createdAt,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 58,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (trend[index]
                                                                  .likedByAuthUser ==
                                                              true) {
                                                            likeAnnouncement(
                                                                trend[index].id,
                                                                0);
                                                          } else {
                                                            likeAnnouncement(
                                                                trend[index].id,
                                                                1);
                                                          }
                                                        },
                                                        child: Row(
                                                          children: [
                                                            trend[index].likedByAuthUser ==
                                                                    true
                                                                ? Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color:
                                                                        topColor,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .favorite_outline,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              '${trend[index].likesCountFormatted}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Views',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                            '${trend[index].viewsCountFormatted}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
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
                                      }),
                                    ),
                                  );
                                }
                              },
                            )
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
