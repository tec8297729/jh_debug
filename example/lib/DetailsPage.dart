import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    jhDebug.init(
      context: context,
      hideCustomTab: false,
      btnTap1: () {
        print('点击第一个按钮');
      },
      btnTap2: () {
        print('${jhDebug.getPrintLogAll}');
      },
      customTabTitle: '自定义tab专栏',
      customTabWidget: Container(
        child: Text('data'),
      ),
      // customBottomWidge: Container(
      //   child: Text('自定义按钮区域'),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('jonhuu.com')),
      // 这里需要说明。最外层还有在套Row这类组件，外层也是要使用撑开组件的
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('全局btn'),
              onPressed: () {
                jhDebug.showDebugBtn();
                // showDebugBtn();
              },
            ),
          ),
        ],
      ),
    );
  }
}
