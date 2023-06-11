import 'dart:async';

import 'package:first_app/components/colors.dart';
import 'package:first_app/feature/pages/connectivity_provider.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/welcome_screen.dart';
import 'package:first_app/models/api_response.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'news_details.dart';
import 'package:notification_permissions/notification_permissions.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void _loadUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var name = localStorage.getString('name');
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomeScreenPage()),
          (route) => false);
    } else {
      ApiResponse response = await getUserDetails();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Dashboard()),
            (route) => false);
        SnackBar(
          content: Text('Welcome back, ${name}'),
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
        );
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("You have been logged out"),
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.error}")));
        // print(response.error);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    listenForPushNotifications(context);

    Timer(Duration(seconds: 4), _loadUserInfo);
  }

  void listenForPushNotifications(BuildContext context) {
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      final data = result.notification.additionalData;
      final announcemet_id = data!['announcemet_id'];
      debugPrint("background notification announcemet_id $announcemet_id.");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DetailNews(title: announcemet_id),
      //   ),
      // );

      Navigator.of(context).pushAndRemoveUntil(
          // this is not a  permanent solution cus it does not make sense
          MaterialPageRoute(
              builder: (context) => DetailNews(title: announcemet_id)),
          (route) => false);
    });

    // OneSignal.shared.setNotificationWillShowInForegroundHandler(
    //   (OSNotificationReceivedEvent notification) async {
    //     final data = notification.notification.additionalData;
    //     final announcemet_id = data!['announcemet_id'];
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => DetailNews(title: announcemet_id),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 7), () {
    //   _loadUserInfo();
    // });
    return Scaffold(
        backgroundColor: topColor,
        body: SafeArea(
          child:
              Consumer<ConnectivityProvider>(builder: (context, provider, _) {
            if (provider.status == ConnectivityStatus.Offline) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: topColor,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/f.png"),
                                fit: BoxFit.contain)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Students Represantative Council KsTU",
                        style: TextStyle(
                            color: bottomColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Spacer(),
                      const Text(
                        "No internet connection",
                        style: TextStyle(
                            color: bottomColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: topColor,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/f.png"),
                                fit: BoxFit.contain)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Students Represantative Council KsTU",
                        style: TextStyle(
                            color: bottomColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Spacer(),
                      SpinKitFadingCircle(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: index.isEven ? bottomColor : bottomColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        },
                        size: 60,
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              );
            }
          }),
        ));
  }
}
