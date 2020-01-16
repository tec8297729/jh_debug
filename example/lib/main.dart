import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import 'TestPage.dart';

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
