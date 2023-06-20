import 'package:first_app/components/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/services/connectivity_provider.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_app/components/trending_component.dart';

class TrendingNewsPage extends StatefulWidget {
  const TrendingNewsPage({super.key});

  @override
  State<TrendingNewsPage> createState() => _TrendingNewsPageState();
}

class _TrendingNewsPageState extends State<TrendingNewsPage> {
  bool isLoading = false;
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
                        child: Consumer<ConnectivityProvider>(
                            builder: (context, provider, _) {
                          if (provider.status == ConnectivityStatus.Offline) {
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: bottomColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 18.0),
                                child: TrendingShimmer(),
                              ),
                            );
                          } else {
                            return Container(
                                // height: 100,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: bottomColor,
                                // color: Colors.red,

                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30))),
                                child: ListView(
                                            physics: BouncingScrollPhysics(),
                                            

                                  children: [Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: FutureBuilder<List<Announcement>>(
                                        future: trendProvider.fetchTrend(1),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return TrendingShimmer();
                                          } else if (snapshot.hasError) {
                                            logout().then((value) => {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginPage()),
                                                          (route) => false)
                                                });
                                            return Center();
                                          } else {
                                                   final trend =
                                                      trendProvider.trend;
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: TrendingComponent(gottenData: trend,page: 2,hasLimit: false,isTrending:true),
                                                  );
                                                
                                          }
                                        }),
                                  ),]
                                ));
                          }
                        }))
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
