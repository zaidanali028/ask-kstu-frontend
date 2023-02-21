import 'package:first_app/feature/colors.dart';
import 'package:first_app/glassmorphic_container.dart';
import 'package:flutter/material.dart';

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
                      onPressed: () {},
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
                  children: const [
                    DashboardIcons(
                      icons: Icons.home,
                      title: "Dashboard",
                    ),
                    DashboardIcons(
                      icons: Icons.book,
                      title: "HomeWork",
                    ),
                    DashboardIcons(
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
                  children: const [
                    DashboardIcons(
                      icons: Icons.home,
                      title: "Fee Details",
                    ),
                    DashboardIcons(
                      icons: Icons.home,
                      title: "Examination",
                    ),
                    DashboardIcons(
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
                  children: const [
                    DashboardIcons(
                      icons: Icons.calendar_month,
                      title: "Calendar",
                    ),
                    DashboardIcons(
                      icons: Icons.home,
                      title: "Notice Board",
                    ),
                    DashboardIcons(
                      icons: Icons.person,
                      title: "My Profile",
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: CustomGlassmorphicContainer(
                  width: double.infinity,
                  height: 40,
                  borderRadius: 10,
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
              )
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
  }) : super(key: key);
  final String title;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
