import 'dart:convert';
import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/components/side_menu.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/news_details.dart';
import 'package:first_app/feature/pages/notice_board_shimmer.dart';
import 'package:first_app/feature/pages/trending_shimmer.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/notice_board.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/feature/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:notification_permissions/notification_permissions.dart';


// Make some changes /  Push to github on Date: 04/06/2023 Time:03:55am

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  var name;
  var index;
  var image;
  var id;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  @override
  initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    requestNotificationPermission_();
    getUser();
    listenForPushNotifications(context);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isSideBarClosed = true;
  bool isSideMenuClosed = true;

  void getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      index = localStorage.getInt('index');
      image = localStorage.getString('image');
      id = localStorage.getInt('id');
    });
  }

  showAlertDialog(BuildContext context, Function() runthis) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: runthis,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Receive notification alerts"),
      content: Text(
          'This app would like to send you push notifications when there is any activity on your account'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void requestNotificationPermission_() async {
    // open prompt for user to enable notification
    PermissionStatus permissionStatus =
        await NotificationPermissions.getNotificationPermissionStatus();
    // if(permissionStatus == PermissionStatus.denied) {
    //   // if user explicitly denied notifications, we don't want to show them again
    //   return;
    // }

    if (permissionStatus != PermissionStatus.granted) {
      if (!mounted) return;

      // showConfirmDialog(context, title: 'Receive notification alerts',
      //   subtitle: 'This app would like to send you push notifications when there is any activity on your account',
      //   onConfirmTapped: () async {
      //     }
      //   },
      // );
      showAlertDialog(context, () async {
        final requestResponse =
            await NotificationPermissions.requestNotificationPermissions();
        if (requestResponse == PermissionStatus.granted) {
          // user granted permission
          registerUserForPushNotification();
          return;
        }
      });
    } else {
      registerUserForPushNotification();
    }
  }

  void registerUserForPushNotification() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var user_id = localStorage.getInt('userId');
    print("in dashboard!: ${user_id}");

    var myCustomUniqueUserId = "${user_id}";
    //await OneSignal.shared.removeExternalUserId();
    final setExtPushIdResponse =
        await OneSignal.shared.setExternalUserId(myCustomUniqueUserId);
    debugPrint(
        "setExtPushIdResponse: $setExtPushIdResponse :: newDeviceId: $myCustomUniqueUserId");

    if (setExtPushIdResponse['push']['success'] != null) {
      if (setExtPushIdResponse['push']['success'] is bool) {
        final status = setExtPushIdResponse['push']['success'] as bool;
        // if (status) {
        //   ShowwcaseStorage.setPushRegistrationStatus = "registered";
        // }
      } else if (setExtPushIdResponse['push']['success'] is int) {
        final status = setExtPushIdResponse['push']['success'] as int;
        // if (status == 1) {
        //   ShowwcaseStorage.setPushRegistrationStatus = "registered";
        // }
      }
      debugPrint(
          "registered for push: ${setExtPushIdResponse['push']['success']}");
    }
  }

// HANDING APP NOTIFICATIONS
  void listenForPushNotifications(BuildContext context) {
    // OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    //   final data = result.notification.additionalData;
    //   final announcemet_id = data!['announcemet_id'];
    //   debugPrint("background notification announcemet_id $announcemet_id.");
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => DetailNews(title: announcemet_id),
    //     ),
    //   );
    // });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent notification) async {
        final data = notification.notification.additionalData;
        final announcemet_id = data!['announcemet_id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNews(title: announcemet_id),
          ),
        );
      },
    );
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
  Widget build(BuildContext context) {
    final noticeProvider =
        Provider.of<NoticeBoardProvider>(context, listen: false);
    final trendProvider =
        Provider.of<TrendingNewsProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: topColor,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Stack(
                children: [
                  AnimatedPositioned(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(milliseconds: 200),
                      width: 288,
                      left: isSideMenuClosed ? -288 : 0,
                      height: MediaQuery.of(context).size.height,
                      child: SideMenu()),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                          animation.value - 30 * animation.value * pi / 180),
                    child: AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      child: Transform.translate(
                        offset: Offset(animation.value * 270, 0),
                        child: Transform.scale(
                          scale: scaleAnimation.value,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 45,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      "${name}",
                                                      style: TextStyle(
                                                          color: bottomColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${index}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15),
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
                                                padding: const EdgeInsets.only(
                                                    top: 18),
                                                child: Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      maxRadius: 24,
                                                      minRadius: 24,
                                                      backgroundColor:
                                                          bottomColor,
                                                      backgroundImage: image !=
                                                              "1"
                                                          ? NetworkImage(
                                                              "${user_img_uri}${image}")
                                                          : NetworkImage(
                                                              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: CircleAvatar(
                                                        minRadius: 7,
                                                        maxRadius: 7,
                                                        backgroundColor:
                                                            Colors.red,
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
                                      height:
                                          MediaQuery.of(context).size.height -
                                              50,
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
                                                horizontal: 10.0,
                                                vertical: 15.0),
                                            child: Text(
                                              "Notice Board",
                                              style: TextStyle(
                                                  color: topColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          FutureBuilder<List<Announcement>>(
                                            future:
                                                noticeProvider.fetchNotice(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0),
                                                    child: Container(
                                                        height: 243,
                                                        child: ListView(
                                                            scrollDirection:
                                                                Axis.horizontal,
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
                                                logout().then((value) => {
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          LoginPage()),
                                                              (route) => false)
                                                    });
                                                return Text('');
                                              } else {
                                                final noticeboard =
                                                    snapshot.data!;
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Container(
                                                    height: 250,
                                                    child: ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount:
                                                          noticeboard.length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: ((context) =>
                                                                        DetailNews(
                                                                            title:
                                                                                noticeboard[index].id))));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        15.0),
                                                            child: Container(
                                                              width: 160,
                                                              height: 150,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      topColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          138,
                                                                      //
                                                                      decoration: BoxDecoration(
                                                                          image: noticeboard[index].featured_image != null
                                                                              ? DecorationImage(image: NetworkImage("${announcement_imgUri}${noticeboard[index].featured_image}"), fit: BoxFit.fill)
                                                                              : DecorationImage(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"), fit: BoxFit.fill),
                                                                          color: topColor,
                                                                          borderRadius: BorderRadius.circular(10)),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Text(
                                                                      "${noticeboard[index].title.trim()}",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              17.5),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "${DateTime.parse(noticeboard[index].created_at)}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          fontSize:
                                                                              15),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
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
                                                vertical: 15.0,
                                                horizontal: 10.0),
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
                                                logout().then((value) => {
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          LoginPage()),
                                                              (route) => false)
                                                    });
                                                return Center();
                                              } else {
                                                final trend = snapshot.data!;
                                                return Container(
                                                  height: 530,
                                                  width: double.infinity,
                                                  child: ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount: trend.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return Container(
                                                        width: double.infinity,
                                                        height: 320,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: ((context) =>
                                                                              DetailNews(title: trend[index].id))));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 200,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image: trend[index].featured_image !=
                                                                              null
                                                                          ? DecorationImage(
                                                                              image: NetworkImage("${announcement_imgUri}${trend[index].featured_image}"),
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
                                                                              DetailNews(title: trend[index].id))));
                                                                },
                                                                child: Text(
                                                                  trend[index]
                                                                      .title
                                                                      .trim(),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
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
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Text(
                                                                            '${DateTime.parse(trend[index].created_at)}',
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.fade,
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    // SizedBox(
                                                                    //   width: 58,
                                                                    // ),

                                                                    Spacer(),
                                                                    Row(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // AudioPlayer().play(AssetSource("audio/my_audio.mp3"));
                                                                            if (trend[index].liked_by_auth_user ==
                                                                                true) {
                                                                              likeAnnouncement(trend[index].id, 0);
                                                                            } else {
                                                                              likeAnnouncement(trend[index].id, 1);
                                                                            }
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              trend[index].liked_by_auth_user == true
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
                                                                                '${trend[index].likes_count_formatted}',
                                                                                style: TextStyle(color: Colors.grey),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                12),
                                                                        FaIcon(
                                                                            FontAwesomeIcons
                                                                                .eye,
                                                                            color:
                                                                                Colors.grey),
                                                                        const SizedBox(
                                                                          width:
                                                                              6,
                                                                        ),
                                                                        Text(
                                                                          '${trend[index].views_count_formatted}',
                                                                          style:
                                                                              TextStyle(color: Colors.grey),
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
                                                                color:
                                                                    Colors.grey,
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
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    left: isSideMenuClosed ? 0 : 220,
                    duration: Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () {
                        if (isSideMenuClosed) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                        setState(() {
                          isSideBarClosed = !isSideBarClosed;
                          isSideMenuClosed = !isSideMenuClosed;
                        });
                      },
                      child: SafeArea(
                        child: Container(
                          margin: EdgeInsets.only(left: 16, top: 17),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 3),
                                    blurRadius: 8)
                              ]),
                          child: isSideBarClosed
                              ? Icon(Icons.menu)
                              : Icon(Icons.close),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
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
