import 'package:flutter/material.dart';
import 'package:jh_debug/utils/utls.dart';

// 底部按钮区组件
class BottomWrap extends StatelessWidget {
  BottomWrap({
    required this.customBottomWidge,
    required this.btnTap1,
    required this.btnTap2,
    required this.btnTap3,
    required this.btnTitle1,
    required this.btnTitle2,
    required this.btnTitle3,
  });
  final Widget? customBottomWidge;
  final VoidCallback? btnTap1;
  final VoidCallback? btnTap2;
  final VoidCallback? btnTap3;
  final String? btnTitle1;
  final String? btnTitle2;
  final String? btnTitle3;

  @override
  Widget build(BuildContext context) {
    if (customBottomWidge != null) return customBottomWidge as Widget;
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      width: double.infinity,
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: <Widget>[
          _btnWrap(context, title: '${btnTitle1 ?? '开发'}', onPressed: btnTap1),
          _btnWrap(context, title: '${btnTitle2 ?? '调试'}', onPressed: btnTap2),
          _btnWrap(context, title: '${btnTitle3 ?? '生产'}', onPressed: btnTap3),
        ],
      ),
    );
  }

  // 按钮基础组件
  _btnWrap(BuildContext context,
      {required String title, VoidCallback? onPressed}) {
    return Container(
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          if (onPressed != null) {
            onPressed();
          } else {
            JhUtils.toastTips('请自定义你的按钮事件');
          }
        },
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(color: Colors.white),
          ),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
        ),
      ),
    );
  }
}
