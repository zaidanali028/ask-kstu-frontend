import 'package:first_app/components/colors.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/models/annoucement_key_moment.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/key_moments_service.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class KeyMomentContainer extends StatefulWidget {
  const KeyMomentContainer({super.key, required this.title});
  final int title;

  @override
  State<KeyMomentContainer> createState() => _KeyMomentContainerState();
}

class _KeyMomentContainerState extends State<KeyMomentContainer> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final keymoments = Provider.of<KeyMomentProvider>(context, listen: false);
    return Container(
        width: double.infinity,
        height: 500,
        child: FutureBuilder<List<AnnouncementKeyMoments>>(
            future: keymoments.fetchKeymoment(widget.title),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? topColor : topColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                    size: 80,
                  ),
                );
              } else {
                final keymoments = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: keymoments.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            "${keymoments[index].imageDescription}",
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${key_moment_uri}${keymoments[index].image}"),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Text(
                                  "${keymoments[index].imageSubTitle}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.7)),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                            ],
                          )
                        ],
                      );
                    });
              }
            }));
  }
}
