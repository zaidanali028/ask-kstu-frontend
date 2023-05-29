import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/models/annoucement_key_moment.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/key_moments_service.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyMomentContainer extends StatefulWidget {
   KeyMomentContainer({super.key, required this.title, required this.marignTop});
  final int title;
  double marignTop;

  @override
  State<KeyMomentContainer> createState() => _KeyMomentContainerState();
}

class _KeyMomentContainerState extends State<KeyMomentContainer> {
  ScrollController _scrollController = ScrollController();
  void _handleScroll() {
    if (_scrollController.position.pixels > 0) {
      setState(() {
        if (widget.marignTop == 50) {
          widget.marignTop = 50;
        } else {
          widget.marignTop -= 10;
        }
      });
    } else if (_scrollController.position.pixels == 0) {
      setState(() {
        widget.marignTop = 180;
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
    final keymoments = Provider.of<KeyMomentProvider>(context, listen: false);
    return Container(
        width: double.infinity,
        height: 700,
        child: FutureBuilder<List<AnnouncementKeyMoments>>(
            future: keymoments.fetchKeymoment(widget.title),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                logout().then((value) => Navigator.of(context)
                    .pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false));
                return Center();
              }else {
                final keymoments = snapshot.data!;
                return ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: keymoments.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            "${keymoments[index].imageDescription}",
                            style: TextStyle(fontSize: 15, color: Colors.black),
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
                                  style: TextStyle(fontSize: 15),
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
