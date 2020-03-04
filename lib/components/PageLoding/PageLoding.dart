import 'package:flutter/material.dart';

class PageLoading extends StatelessWidget {
  PageLoading({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(title ?? '加载中...'),
        ),
      ],
    );
  }
}
