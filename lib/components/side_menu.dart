import 'package:first_app/components/colors.dart';
import 'package:first_app/feature/pages/about_page.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/notice_board.dart';
import 'package:first_app/feature/pages/trending_news.dart';
import 'package:first_app/feature/pages/update_password_page.dart';
import 'package:first_app/feature/pages/user_profile.dart';
import 'package:first_app/components/info_card.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var name;
  var indexNo;
  var image;

  void getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      indexNo = localStorage.getInt('index');
      image = localStorage.getString('user_img');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  void mylauntcher(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    SimpleFontelicoProgressDialog _dialog =
        SimpleFontelicoProgressDialog(context: context);
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: topColor,
        child: SafeArea(
          child: Column(
            children: [
              InfoCard(
                name: "${name}",
                indexNo: "${indexNo}",
                image: image,
              ),
              SizedBox(
                height: 40,
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.home,
                title: "Dashboard",
                myfunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.person_alt_circle_fill,
                title: "Profile",
                myfunction: () async{
                  _dialog.show(
                      message: 'Waiting...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfilePage()));
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.shield_lefthalf_fill,
                title: "Notice Board",
                myfunction: () async{
                  _dialog.show(
                      message: 'Waiting...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllNoticeBoardPage()));
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.sun_haze_fill,
                title: "Trending News",
                myfunction: () async{
                  _dialog.show(
                      message: 'Waiting...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrendingNewsPage()));
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.globe,
                title: "Kstu V-class",
                myfunction: () async {
                  _dialog.show(
                      message: 'Opening...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  mylauntcher('https://vclass.kstu.edu.gh/login/index.php');
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.cube_box_fill,
                title: "Kstu Portal",
                myfunction: () async {
                  _dialog.show(
                      message: 'opening...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  mylauntcher('https://portal.kstu.edu.gh/students/login');
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.cube_box,
                title: "Kstu Site",
                myfunction: () async {
                  _dialog.show(
                      message: 'opening...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  mylauntcher('https://kstu.edu.gh/');
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.piano,
                title: "Change Password",
                myfunction: () async{
                  _dialog.show(
                      message: 'waiting...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePasswordPage()));
                },
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.question_circle,
                title: "About",
                myfunction: () async{
                  _dialog.show(
                      message: 'waiting...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutPage()));},
              ),
              SizedBox(
                height: 70,
              ),
              SideMenuTitle(
                iconData: CupertinoIcons.tray_arrow_up_fill,
                title: "Logout",
                isLast: true,
                myfunction: () async {
                  _dialog.show(
                      message: 'Logging out...',
                      type: SimpleFontelicoProgressDialogType.hurricane);
                  await Future.delayed(Duration(seconds: 1));
                  _dialog.hide();
                  logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false)
                      });
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenuTitle extends StatelessWidget {
  SideMenuTitle(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.myfunction,
      this.isLast = false})
      : super(key: key);
  String title;
  IconData iconData;
  VoidCallback myfunction;
  bool isLast;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: isLast
              ? null
              : Divider(
                  color: Colors.white24,
                  height: 1,
                ),
        ),
        Stack(
          children: [
            ListTile(
              onTap: myfunction,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
