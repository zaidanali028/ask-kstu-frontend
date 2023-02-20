
import 'package:first_app/feature/colors.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;


    return Stack(
      children: [
        Row(
          children: [
            Container(
              // height:50,
              width: halfScreenWidth, color: bottomColor,
            ),
            Container(width: halfScreenWidth, color: topColor
                // height:50
                )
          ],
        ),
        homeScreen(context, topColor, bottomColor, 60.0)
      ],
    );
  }
}

Widget homeScreen(context, topColor, bottomColor, radius) {
  double halfScreenHeight = MediaQuery.of(context).size.height / 3;
  double halfScreenHeight2 = MediaQuery.of(context).size.height / 4;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        // flex: 2,
        child: Container(
          height: halfScreenHeight,
          decoration: BoxDecoration(
            color: topColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
            ),
          ),
          child: topPortion(context),
        ),
      ),
      Expanded(
        // flex: 3,
        child: Container(
            // height: halfScreenHeight2,
            decoration: BoxDecoration(
              color: bottomColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(radius),
              ),
            ),
            child: bottomPortion(context)),
      )
    ],
  );
}

Widget topPortion(context) {
  //  double halfScreenWidth = MediaQuery.of(context).size.width / 2;
  double topPortionTopHeight = MediaQuery.of(context).size.height / 5;
  double topPortionBottomHeight = MediaQuery.of(context).size.height / 10;
  return Column(
  
    // horizontal).
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: 200,
          height: topPortionTopHeight,
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
              // color: Colors.red,

              ),
          child: Image.asset('assets/images/f.png')),
      Container(
        height: topPortionBottomHeight,
        decoration: BoxDecoration(

            // color: Colors.blue,

            ),
        child: const Center(
            child: Text(
          'SIGN IN',
          style: TextStyle(fontSize: 40, color: Colors.white),
        )),
      )
    ],
  );
}

Widget bottomPortion(context) {
  return ListView(
    children: [
      SizedBox(
        height: 50,
      ),
       inputField("Username"),
          inputField("Password"),
          signingButton("Sign In")
      
    ],
  );
}

Widget inputField(label) {
  return Container(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.all(25.0),
          child: TextField(
            decoration: InputDecoration(
              label: Text(label),
              hintText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          )),
    ]),
  );
}

Widget signingButton(label) {
  const topColor = Color(0xFF4E489C);

  return Center(
      child: Container(
          decoration: BoxDecoration(
              color: topColor, borderRadius: BorderRadius.circular(15)),
          width: 350,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )));
}
