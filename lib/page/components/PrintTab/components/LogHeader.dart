import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/utils/utls.dart';

/// 日志内容区头部组件
class LogHeader extends StatefulWidget {
  @override
  _LogHeaderState createState() => _LogHeaderState();
}

class _LogHeaderState extends State<LogHeader> {
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 3),
      height: 36,
      color: Colors.white,
      child: IndexedStack(
        index: 0,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  '点击行: ${''}',
                  style: TextStyle(color: _textColor),
                ),
              ),
              clearBtnWidget(),
            ],
          ),
        ],
      ),
    );
  }

  // 暂定
  Widget searchBtnWidget() {
    return baseBtnWrap(
      text: '搜索',
      onPressed: () {
        setState(() {});
      },
    );
  }

  /// 清空日志按钮组件
  Widget clearBtnWidget() {
    return baseBtnWrap(
      text: '清空',
      onPressed: () {
        setState(() {
          jhDebug.clearPrintLog();
          JhUtils.toastTips('清空成功');
        });
      },
    );
  }

  /// 按钮基础层
  Widget baseBtnWrap(
      {@required String text, @required VoidCallback onPressed}) {
    return Container(
      // width: 90,
      child: RaisedButton(
        onPressed: onPressed,
        textColor: Colors.white,
        color: Color(0xFF1C88E5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
