import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug_example/TestPage.dart';

import 'DetailsPage.dart';

void main() {
  jhDebugMain(
    appChild: MyApp(),
    debugMode: DebugMode.inConsole,
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
    // jhDebug.init(
    //   hideCustomTab: true,
    //   btnTap1: () {
    //     print('点击第一个按钮');
    //   },
    //   btnTitle1: '测试按钮22',
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: TestPage(),
      routes: {
        '/': (BuildContext context) => TestPage(),
        '/detailsPage': (BuildContext context) => DetailsPage(),
      },
    );
  }
}
