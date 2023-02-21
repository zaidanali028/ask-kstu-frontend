import 'package:first_app/feature/colors.dart';
import 'package:first_app/glassmorphic_container.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        flex: 4,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: const BoxDecoration(
                              color: topColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: bottomColor,
                                        size: 25,
                                      ),
                                    ),
                                    const Text(
                                      "Profile",
                                      style: TextStyle(
                                          color: bottomColor, fontSize: 25),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  children: const [
                                    CircleAvatar(
                                      minRadius: 60,
                                      maxRadius: 60,
                                      backgroundColor: bottomColor,
                                      backgroundImage: AssetImage(
                                          "assets/images/student_profile.jpeg"),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Saani Iddi",
                                      style: TextStyle(
                                          color: bottomColor, fontSize: 30),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Class BTC 3",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: bottomColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10),
                            child: Column(
                              children: [
                                const ProfileDetails(
                                  subtitle: "052141350070",
                                  title: "Student Number",
                                ),
                                const ProfileDetails(
                                  subtitle: "21/02/2023",
                                  title: "Date of Birth",
                                ),
                                const ProfileDetails(
                                  subtitle: "0554139989",
                                  title: "Emergency Contact",
                                ),
                                const ProfileDetails(
                                  subtitle: "052141350070",
                                  title: "Student Number",
                                ),
                                const ProfileDetails(
                                  subtitle: "iddishani1@gmail.com",
                                  title: "Email Address",
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: CustomGlassmorphicContainer(
                                    width: double.infinity,
                                    height: 50,
                                    borderRadius: 25,
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: kpink,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: const Center(
                                          child: Text(
                                        "Ask for Update",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
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

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Spacer(),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        )
      ],
    );
  }
}
