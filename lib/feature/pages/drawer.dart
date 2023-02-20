import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/home_page.dart';
import 'package:first_app/feature/pages/userwithout_login.dart';
import 'package:first_app/glassmorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        width: MediaQuery.of(context).size.width,
        child: Container(
            decoration: const BoxDecoration(
                color: kblue,
                image: DecorationImage(
                    image: AssetImage("assets/images/nature.jpg"),
                    fit: BoxFit.cover)),
            child: CustomGlassmorphicContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomGlassmorphicContainer(
                            width: 150,
                            height: 40,
                            borderRadius: 6,
                            child: Center(
                              child: Text(
                                "Ask Kstu",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(const HomePage()),
                      child: const ListTile(
                        title: Text(
                          "Home",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfile()));
                      },
                      child: const ListTile(
                        title: Text(
                          "Profile",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text(
                          "Registration",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text(
                          "Results",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.restore_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text(
                          "Fees",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.radio,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text(
                          "Notification",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text(
                          "Settings",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text(
                          "About",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.help,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    CustomGlassmorphicContainer(
                        borderRadius: 8,
                        width: double.infinity,
                        height: 40,
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: kpink,
                          ),
                          child: const Center(
                              child: Text(
                            "LogOut",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                        ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
