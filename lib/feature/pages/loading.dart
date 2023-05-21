import 'dart:async';

import 'package:first_app/feature/colors.dart';
import 'package:first_app/feature/pages/dashboard.dart';
import 'package:first_app/feature/pages/login_page.dart';
import 'package:first_app/feature/pages/welcome_screen.dart';
import 'package:first_app/models/api_response.dart';
import 'package:first_app/models/constant.dart';
import 'package:first_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:notification_permissions/notification_permissions.dart';
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void _loadUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token');
    var name = localStorage.getString('name');
    // if (token != null) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => Dashboard()),
    //       (route) => false);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Welcome Back $name"),
    //       backgroundColor: topColor,
    //     ),
    //   );
    // } else {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => WelcomeScreenPage()),
    //       (route) => false);
    // }
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
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
        )
    );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.error}")));
        // print(response.error);
      }
    }
  }


  showAlertDialog(BuildContext context,Function() runthis) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: runthis,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Receive notification alerts"),
    content: Text('This app would like to send you push notifications when there is any activity on your account'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



  void  requestNotificationPermission_()async {
print('invoked 2');
  // open prompt for user to enable notification
    PermissionStatus permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();
    // if(permissionStatus == PermissionStatus.denied) {
    //   // if user explicitly denied notifications, we don't want to show them again
    //   return;
    // }

    if(permissionStatus != PermissionStatus.granted){

      if(!mounted) return;

      // showConfirmDialog(context, title: 'Receive notification alerts',
      //   subtitle: 'This app would like to send you push notifications when there is any activity on your account',
      //   onConfirmTapped: () async {
      //     }
      //   },
      // );
showAlertDialog(context,()async{
       final requestResponse =  await NotificationPermissions.requestNotificationPermissions();
          if(requestResponse == PermissionStatus.granted){
            // user granted permission
            registerUserForPushNotification();
            return;
     

}});
     }else {
      registerUserForPushNotification();
    }

}

void registerUserForPushNotification()async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

     var user_id = localStorage.getInt('id');
     print("here!: ${user_id}");

  
  var myCustomUniqueUserId = "${user_id}";
    //await OneSignal.shared.removeExternalUserId();
    final setExtPushIdResponse = await OneSignal.shared.setExternalUserId(myCustomUniqueUserId);
    debugPrint("setExtPushIdResponse: $setExtPushIdResponse :: newDeviceId: $myCustomUniqueUserId");

    if (setExtPushIdResponse['push']['success'] != null) {
      if (setExtPushIdResponse['push']['success'] is bool) {
        final status = setExtPushIdResponse['push']['success'] as bool;
        // if (status) {
        //   ShowwcaseStorage.setPushRegistrationStatus = "registered";
        // }
      } else if (setExtPushIdResponse['push']['success'] is int) {
        final status = setExtPushIdResponse['push']['success'] as int;
        // if (status == 1) {
        //   ShowwcaseStorage.setPushRegistrationStatus = "registered";
        // }
      }
      debugPrint("registered for push: ${setExtPushIdResponse['push']['success']}");
    }
  
}

  @override
  void initState() {
    super.initState();
    print('invokedRR');
    requestNotificationPermission_();

    Timer(Duration(seconds: 4), _loadUserInfo);
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 7), () {
    //   _loadUserInfo();
    // });
    return Scaffold(
        backgroundColor: topColor,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: topColor,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            ),
          ),
        ));
  }
}
