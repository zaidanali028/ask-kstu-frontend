import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/services/notice_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllNoticeBoardPage extends StatefulWidget {
  const AllNoticeBoardPage({super.key});

  @override
  State<AllNoticeBoardPage> createState() => _AllNoticeBoardPageState();
}

class _AllNoticeBoardPageState extends State<AllNoticeBoardPage> {
  @override
  Widget build(BuildContext context) {
    final noticeboardProvider =
        Provider.of<NoticeBoardProvider>(context, listen: false);
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
                                      Icons.arrow_back_ios,
                                      color: bottomColor,
                                      size: 25,
                                    ),
                                  ),
                                  const Text(
                                    "Notice Board",
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
                        flex: 7,
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
                              child: FutureBuilder<List<Announcement>>(
                                  future: noticeboardProvider.fetchNotice(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ListView(
                                        children: [
                                          TrendingShimmer(),
                                          TrendingShimmer(),
                                          TrendingShimmer(),
                                          TrendingShimmer(),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('${snapshot.hasError}'),
                                      );
                                    } else {
                                      final noticeboard = snapshot.data!;
                                      return GridView.builder(
                                        physics: BouncingScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 1.5 / 2,
                                          // crossAxisSpacing: 10
                                        ),
                                        itemCount: noticeboard.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return ListView(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: Container(
                                                    width: 160,
                                                    height: 250,
                                                    decoration: BoxDecoration(
                                                        color: topColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 150,
                                                            decoration: BoxDecoration(
                                                                image: noticeboard[index]
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
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "${noticeboard[index].title}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "${DateTime.parse(noticeboard[index].date)}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                fontSize: 15),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }),
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
