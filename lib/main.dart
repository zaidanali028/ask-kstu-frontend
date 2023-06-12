import 'package:first_app/services/connectivity_provider.dart';
import 'package:first_app/feature/pages/loading.dart';
import 'package:first_app/services/key_moments_service.dart';
import 'package:first_app/services/notice_board.dart';
import 'package:first_app/services/trending_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  //Remove this method to stop OneSignal Debugging
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setAppId("7e696d2c-01f7-4742-9a4f-f0a900d76526");



  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => NoticeBoardProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => TrendingNewsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => KeyMomentProvider(),
      ),
      ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
    ],
    child: MyApp(),
  ));
}

// zamaani
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASK-KsTU',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 16),
            bodyText2: TextStyle(fontSize: 14),
          )),
      home: LoadingPage(),
    );
  }
}
