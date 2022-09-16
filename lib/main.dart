import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:custom_splash/custom_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// dart files import
import 'myHomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: CustomSplash(
            logoSize: 200,
            backGroundColor: new Color(0xff1874D2),
            animationEffect: 'fade-in',
            imagePath: 'assets/images/giphy.gif',
            home: MyApp(),
            duration: 50,
            type: CustomSplashType.StaticDuration,
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: MyHomePage(title: 'DocIT'),
      ),
    );
  }
}
