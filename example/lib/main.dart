import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart' show DebugMode, jhDebug, jhDebugMain;
import 'TestPage.dart';
import 'DetailsPage.dart';

void main() {
  jhDebugMain(
    appChild: MyApp(),
    debugMode: DebugMode.inConsole,
    errorCallback: (FlutterErrorDetails) {},
    beforeAppChildFn: (() async {
      Completer<void> completer = Completer<void>(); // 创建一个Completer对象

      // 模拟定时器处理，假设需要不定时间处理
      Timer(const Duration(seconds: 3), () {
        print('定时器处理完成');
        completer.complete(); // 完成Completer，通知任务完成
      });

      // 在Completer完成前等待
      await completer.future;

      print('执行前!');
    }),
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
    print('main');
    return MaterialApp(
      // home: TestPage(),
      // showPerformanceOverlay: true,
      theme: ThemeData.light(),
      navigatorKey: jhDebug.getNavigatorKey,
      routes: {
        '/': (BuildContext context) => TestPage(),
        '/detailsPage': (BuildContext context) => DetailsPage(),
      },
    );
  }
}
