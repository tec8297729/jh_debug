import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  jhDebugMain(
    appChild: MyApp(),
    debugMode: DebugMode.self,
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    jhDebug.init(
      hideCustomTab: true,
      btnTap1: () {
        print('点击第一个按钮');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('构建成功');
    return MaterialApp(
      locale: Locale('zh', 'CH'),
      navigatorKey: jhDebug.getNavigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            // Center(
            //   child: Text('Running on: $_platformVersion\n'),
            // ),
            RaisedButton(
              child: Text('按钮'),
              onPressed: () {
                print('点击一次');

                jhDebug.showLog();
              },
            ),
            RaisedButton(
              child: Text('error'),
              onPressed: () {
                // _tabController = TabController(length: 1, vsync: this);
                throw "Sample for exception";
                // Future.error("error自定义错误");
              },
            ),
          ],
        ),
      ),
    );
  }
}
