import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('jonhuu.com')),
      // 这里需要说明。最外层还有在套Row这类组件，外层也是要使用撑开组件的
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  color: Colors.red,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
