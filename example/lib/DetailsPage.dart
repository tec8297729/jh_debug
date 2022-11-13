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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('jonhuu.com')),
      // 这里需要说明。最外层还有在套Row这类组件，外层也是要使用撑开组件的
      body: Column(
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text('全局btn'),
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
