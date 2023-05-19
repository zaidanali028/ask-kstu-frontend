import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/calendar_page.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/notice_board.dart';
import 'package:first_app/feature/pages/settings_listtile.dart';
import 'package:first_app/feature/pages/trending_news.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                    "Settings",
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
                                    horizontal: 2.0, vertical: 18.0),
                                child: ListView(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfilePage())),
                                      child: SettingsListTile(
                                          title: 'My Profile',
                                          trailingIcon: Icons.arrow_forward_ios,
                                          leadingIcon: Icons.person),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var uri =
                                            Uri.parse('https://kstu.edu.gh');
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          throw 'Could not launch $uri';
                                        }
                                      },
                                      child: SettingsListTile(
                                          title: 'Kstu Website',
                                          trailingIcon: Icons.arrow_forward_ios,
                                          leadingIcon: Icons.web),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        var uri = Uri.parse(
                                            'https://portal.kstu.edu.gh/students/login');
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          throw 'Could not launch $uri';
                                        }
                                      },
                                      child: SettingsListTile(
                                          title: 'Kstu Portal',
                                          trailingIcon: Icons.arrow_forward_ios,
                                          leadingIcon:
                                              Icons.panorama_horizontal),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrendingNewsPage())),
                                      child: SettingsListTile(
                                          title: 'Notifications',
                                          trailingIcon: Icons.arrow_forward_ios,
                                          leadingIcon: Icons.notifications),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllNoticeBoardPage())),
                                      child: SettingsListTile(
                                          title: 'Campus Blocks',
                                          trailingIcon: Icons.arrow_forward_ios,
                                          leadingIcon: Icons.house_outlined),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CalendarPage())),
                                      child: SettingsListTile(
                                          title: 'Calendar',
                                          trailingIcon: Icons.arrow_forward_ios,
                                          leadingIcon: Icons.calendar_today),
                                    ),
                                    GestureDetector(
                                      onTap: () async{
                                        var uri =
                                            Uri.parse('');
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          throw 'Could not launch $uri';
                                        }

                                      },
                                      child: SettingsListTile(
                                        isLast: true,
                                          title: 'About the app',
                                          trailingIcon: Icons.arrow_forward_ios,
                                          leadingIcon: Icons.favorite),
                                    ),
                                    GestureDetector(
                                      onTap: () async{
                                        var uri =
                                            Uri.parse('');
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          throw 'Could not launch $uri';
                                        }
                                        
                                      },
                                      child: SettingsListTile(
                                        title: 'Help',
                                        trailingIcon: Icons.arrow_forward_ios,
                                        leadingIcon: Icons.help,
                                        isLast: true,
                                      ),
                                    ),
                                  ],
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
}
