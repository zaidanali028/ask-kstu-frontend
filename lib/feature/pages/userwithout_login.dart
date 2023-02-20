import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/drawer.dart';
import 'package:first_app/feature/pages/update_user_profile.dart';
import 'package:first_app/glassmorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: kblue,
            image: DecorationImage(
                image: AssetImage("assets/images/nature.jpg"),
                fit: BoxFit.cover)),
        child: CustomGlassmorphicContainer(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                            onPressed: () => Get.to(const DrawerPage()),
                            icon: const Icon(
                              Icons.line_weight_sharp,
                              color: Colors.white,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CustomGlassmorphicContainer(
                        width: double.infinity,
                        height: 150,
                        borderRadius: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(
                              maxRadius: 50.0,
                              minRadius: 50.0,
                              backgroundColor: kblue,
                              backgroundImage: AssetImage(
                                  "assets/images/student_profile.jpeg"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                const Text(
                                  "Saani Xamani",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                const Text(
                                  "iddishani1@gmail.com",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: CustomGlassmorphicContainer(
                                      width: 200,
                                      height: 40,
                                      borderRadius: 8,
                                      child: Container(
                                        width: 200,
                                        height: 40,
                                        decoration:
                                            const BoxDecoration(color: kpink),
                                        child: const Center(
                                            child: Text(
                                          "LogOut",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                      )),
                                ),
                                Spacer(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        ProfileDetails(
                            title: "Student Number", subtitle: "052141350070"),
                        ProfileDetails(
                            title: "Academic Year", subtitle: "2019-2023"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        ProfileDetails(
                            title: "Department", subtitle: "Computer Science"),
                        ProfileDetails(
                            title: "Date Of Birth", subtitle: "01/03/2000"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        ProfileDetails(
                            title: "Gender", subtitle: "Male"),
                        ProfileDetails(
                            title: "Program", subtitle: "BCT 3"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        ProfileDetails(
                            title: "Phone", subtitle: "0552732025"),
                        ProfileDetails(
                            title: "Address", subtitle: "Kz Block B 213"),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(const UpdateUserProfile()),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CustomGlassmorphicContainer(
                            width: double.infinity,
                            height: 40,
                            borderRadius: 8,
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(color: kpink),
                              child: const Center(
                                  child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 4),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                subtitle,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 6,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: const Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
          const Icon(
            Icons.lock_outline,
            size: 20.0,
          )
        ],
      ),
    );
  }
}
