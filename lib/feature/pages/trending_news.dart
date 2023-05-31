import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/news_details.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:first_app/models/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TrendingNewsPage extends StatefulWidget {
  const TrendingNewsPage({super.key});

  @override
  State<TrendingNewsPage> createState() => _TrendingNewsPageState();
}

class _TrendingNewsPageState extends State<TrendingNewsPage> {
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

  List<dynamic> paginatedData = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListner);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
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
                                "Trending News",
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
                                child: ListView.builder(
                                  controller: scrollController,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: isLoading
                                      ? paginatedData.length + 1
                                      : paginatedData.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final item = paginatedData[index];
                                    if (index == paginatedData.length) {
                                      return CircularProgressIndicator();
                                    } else {
                                      return Container(
                                        width: double.infinity,
                                        height: 320,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              DetailNews(
                                                                  title: item[
                                                                      "id"]))));
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: item["featured_image"] !=
                                                              null
                                                          ? DecorationImage(
                                                              image: NetworkImage(
                                                                  "${announcement_imgUri}${item["featured_image"]}"),
                                                              fit: BoxFit.cover)
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
                                                                  title: item[
                                                                      "id"]))));
                                                },
                                                child: Text(
                                                  item["title"].trim(),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          child: Text(
                                                            '${DateTime.parse(item["created_at"])}',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            AudioPlayer().play(
                                                                AssetSource(
                                                                    "audio/my_audio.mp3"));
                                                            if (item[
                                                                    "liked_by_auth_user"] ==
                                                                true) {
                                                              likeAnnouncement(
                                                                  item["id"],
                                                                  0);
                                                            } else {
                                                              likeAnnouncement(
                                                                  item["id"],
                                                                  1);
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              item["liked_by_auth_user"] ==
                                                                      true
                                                                  ? Icon(
                                                                      CupertinoIcons
                                                                          .hand_thumbsup_fill,
                                                                      color:
                                                                          topColor,
                                                                    )
                                                                  : Icon(
                                                                      CupertinoIcons
                                                                          .hand_thumbsup,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(
                                                                '${item["likes_count_formatted"]}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 12),
                                                        FaIcon(
                                                            FontAwesomeIcons
                                                                .eye,
                                                            color: Colors.grey),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                          '${item["views_count_formatted"]}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
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
                                    }
                                  },
                                ))))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> fetchData() async {
    try {
      final List<dynamic> apiData = await fetchTrendWithPagination(currentPage);
      setState(() {
        paginatedData = paginatedData + apiData;
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _scrollListner() async {
    if (isLoading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      currentPage = currentPage + 1;
      // await fetchData();
      setState(() {
        isLoading = false;
      });
    }
  }
}
