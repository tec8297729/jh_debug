import 'package:flutter/material.dart';
import '../utils/utls.dart';

class BottomWrap extends StatelessWidget {
  BottomWrap({
    @required this.customBottomWidge,
    @required this.btnTap1,
    @required this.btnTap2,
    @required this.btnTap3,
    @required this.initTabsWidget,
  });
  final Widget customBottomWidge;
  final VoidCallback btnTap1;
  final VoidCallback btnTap2;
  final VoidCallback btnTap3;
  final Function initTabsWidget;

  @override
  Widget build(BuildContext context) {
    if (customBottomWidge != null) return customBottomWidge;
    return Container(
      height: 60,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _btnWrap(title: '开发', onPressed: btnTap1),
          _btnWrap(title: '调试', onPressed: btnTap2),
          _btnWrap(title: '生产', onPressed: btnTap3),
        ],
      ),
    );
  }

  // 按钮基础组件
  _btnWrap({@required String title, @required VoidCallback onPressed}) {
    return Container(
      width: 70,
      child: RaisedButton(
        color: Colors.white,
        child: Text(title),
        onPressed: () async {
          if (onPressed != null) {
            onPressed();
          } else {
            toastTips('请自定义你的按钮事件');
          }
          initTabsWidget();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
