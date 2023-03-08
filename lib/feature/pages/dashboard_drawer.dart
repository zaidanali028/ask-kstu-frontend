import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: topColor,
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        color: topColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        maxRadius: 24,
                        minRadius: 24,
                        backgroundColor: bottomColor,
                        backgroundImage:
                            AssetImage("assets/images/student_profile.jpeg"),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Saani Iddi",
                            style: TextStyle(
                              color: bottomColor,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Class BTC 3",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: bottomColor,
                        size: 40,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.home,
                      title: "Dashboard",
                    ),
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.book,
                      title: "HomeWork",
                    ),
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.home,
                      title: "Attendance",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.home,
                      title: "Fee Details",
                    ),
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.home,
                      title: "Examination",
                    ),
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.home,
                      title: "Report Cards",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.calendar_month,
                      title: "Calendar",
                    ),
                    DashboardIcons(
                      callback: () {},
                      icons: Icons.home,
                      title: "Notice Board",
                    ),
                    DashboardIcons(
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfilePage()));
                      },
                      icons: Icons.person,
                      title: "My Profile",
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false)
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: kpink, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "LogOut",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class DashboardIcons extends StatelessWidget {
  const DashboardIcons({
    Key? key,
    required this.title,
    required this.icons,
    required this.callback,
  }) : super(key: key);
  final String title;
  final IconData icons;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            minRadius: 30,
            maxRadius: 30,
            backgroundColor: Colors.white,
            child: Icon(
              icons,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    );
  }
}
