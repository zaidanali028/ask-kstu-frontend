import 'dart:convert';

import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/announcement.dart';

class DetailNews extends StatefulWidget {
  const DetailNews({super.key, required this.title});
  final int title;

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  // final int marignTop = 180;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: topColor,
        body: SafeArea(
          child: FutureBuilder<Announcement>(
              future: TrendingNewsProvider().fetchTrendDetails(widget.title),
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
                                image: NetworkImage(   "${announcement_imgUri}${trend.featured_image}"),
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
                        margin: EdgeInsets.only(top: 180),
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
                          child: ListView(
                            children: [
                              Text(
                                trend.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                color: Color.fromARGB(255, 91, 89, 89),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          trend.created_at,
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
                                  trend.category_id == 2
                                      ? GestureDetector(
                                          onTap: () {
                                            if (trend.liked_by_auth_user == true) {
                                              likeAnnouncement(trend.id, 0);
                                            } else {
                                              likeAnnouncement(trend.id, 1);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              trend.liked_by_auth_user == true
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: topColor,
                                                    )
                                                  : Icon(
                                                      Icons.favorite_outline,
                                                      color: Colors.grey,
                                                    ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                '${trend.likes_count}',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        )
                                      : Text(''),
                                  Spacer(),
                                  trend.category_id == 2
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
                                              '${trend.views}',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        )
                                      : Text('')
                                ],
                              ),
                              Divider(
                                color: Color.fromARGB(255, 91, 89, 89),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 500,
                                  child: FutureBuilder(
                                      future: TrendingNewsProvider()
                                          .fetchKeymoment(widget.title),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Center();
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center();
                                        } else {
                                          return Center();
                                        }
                                      }))
                            ],
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
