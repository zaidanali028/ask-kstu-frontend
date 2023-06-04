import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/key_moments_container.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailNews extends StatefulWidget {
  const DetailNews({super.key, required this.title});
  final int title;

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  double marignTop = 180;
  ScrollController _scrollController = ScrollController();

  void likeAnnouncement(int category_id, int status) async {
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

  void _handleScroll() {
    if (_scrollController.position.pixels > 0) {
      setState(() {
        if (marignTop == 50) {
          marignTop = 50;
        }else{
          marignTop -= 10;
        }
      });
    } else if (_scrollController.position.pixels == 0) {
      setState(() {
        marignTop = 180;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_handleScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final trending = Provider.of<TrendingNewsProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: topColor,
        body: SafeArea(
          child: FutureBuilder(
              future: trending.fetchTrendDetails(widget.title),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final trend = snapshot.data!;
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${announcement_imgUri}${trend['featured_image']}"),
                                fit: BoxFit.cover)),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 10,
                                left: 10,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 30,
                                    ))),
                          ],
                        ),
                      ),
                      Positioned(
                          // bottom: 20,
                          child: Container(
                        margin: EdgeInsets.only(top: marignTop),
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: bottomColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 20),
                          child: AnimatedPositioned(
                            duration: Duration(seconds: 2),
                            child: ListView(
                              controller: _scrollController,
                              children: [
                                Text(
                                  trend['title'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(
                                  color: Color.fromARGB(255, 91, 89, 89),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.alarm,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: 80,
                                          child: Text(
                                            "${trend['created_at']}",
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 58,
                                    ),
                                    trend['category_id'] == 2
                                        ? GestureDetector(
                                            onTap: () {
                                              AudioPlayer().play(AssetSource(
                                                  "audio/my_audio.mp3"));
                                              if (trend['liked_by_auth_user'] ==
                                                  true) {
                                                likeAnnouncement(trend['id'], 0);
                                              } else {
                                                likeAnnouncement(trend['id'], 1);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                trend['liked_by_auth_user'] == true
                                                    ? Icon(
                                                        CupertinoIcons.hand_thumbsup_fill,
                                                        color: topColor,
                                                      )
                                                    : Icon(
                                                        CupertinoIcons.hand_thumbsup,
                                                        color: Colors.grey,
                                                      ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  '${trend['likes_count']}',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          )
                                        : Text(''),
                                    Spacer(),
                                    trend['category_id'] == 2
                                        ? Row(
                                            children: [
                                              Text(
                                                'Views',
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                '${trend['views']}',
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              )
                                            ],
                                          )
                                        : Text('')
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  color: Color.fromARGB(255, 91, 89, 89),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                KeyMomentContainer(title: widget.title)
                              ],
                            ),
                          ),
                        ),
                      ))
                    ]),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: bottomColor,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 18.0),
                        child: ListView(
                          children: [
                            TrendingShimmer(),
                            TrendingShimmer(),
                            TrendingShimmer(),
                            TrendingShimmer(),
                            TrendingShimmer(),
                            TrendingShimmer(),
                            TrendingShimmer(),
                          ],
                        ),
                      ));
                } else {
                  return Center();
                }
              }),
        ));
  }
}
