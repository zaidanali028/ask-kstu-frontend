import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/news_details.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingNewsPage extends StatefulWidget {
  const TrendingNewsPage({super.key});

  @override
  State<TrendingNewsPage> createState() => _TrendingNewsPageState();
}

class _TrendingNewsPageState extends State<TrendingNewsPage> {
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
                                  future: trendProvider.fetchTrend(),
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
                                      final trend = snapshot.data!;
                                      return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                        itemCount: trend.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: double.infinity,
                                            height: 320,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                              width: 80,
                                                              child: Text(
                                                                trend[index]
                                                                    .date,
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
                                                          onTap: () {},
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .favorite_outline,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(
                                                                '${trend[index].likesCount}',
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
                                                            Text('Views',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey)),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              '${trend[index].viewsCount}',
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
