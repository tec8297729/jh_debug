// import 'dart:async';
import 'package:flutter/material.dart';
import '../jh_debug.dart';

/// 浮层按钮
class StackPosBtn extends StatelessWidget {
  StackPosBtn({this.left, this.rigth, this.top, this.bottom});

  final double left;
  final double rigth;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    double handleTop = MediaQuery.of(context).size.height * 0.7;
    if (bottom != null || top != null) {
      handleTop = top ?? null;
    }
    return Positioned(
      top: handleTop,
      right: rigth ?? null,
      left: left ?? null,
      bottom: bottom ?? null,
      child: GestureDetector(
        onDoubleTap: () {
          jhDebug.removeDebugBtn();
        },
        child: Opacity(
          opacity: 0.6,
          child: FloatingActionButton(
            onPressed: () {
              jhDebug.showLog();
            },
            child: Icon(Icons.bug_report, size: 33), // 设置按钮icon图标
            backgroundColor: Colors.blueGrey, // 按钮的背景颜色
          ),
        ),
      ),
    );
  }
}
