import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({super.key});

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                color: kblue,
                image: DecorationImage(
                    image: AssetImage("assets/images/nature.jpg"),
                    fit: BoxFit.cover)),
            child: SafeArea(
                child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () => Get.to(const DashboardDrawer()),
                              icon: const Icon(
                                Icons.line_weight_sharp,
                                color: Colors.white,
                                size: 25,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              const CircleAvatar(
                                maxRadius: 70,
                                minRadius: 70,
                                backgroundColor: kblue,
                                backgroundImage: AssetImage(
                                  "assets/images/student_profile.jpeg",
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 8,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 40,
                                      )))
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                  hintText: "Saani",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ))));
  }
}
