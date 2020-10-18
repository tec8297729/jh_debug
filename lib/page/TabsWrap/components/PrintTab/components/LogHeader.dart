import 'package:flutter/material.dart';
import 'package:jh_debug/components/BaseBtn/BaseBtn.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/utils/utls.dart';

/// 日志内容区头部组件
class LogHeader extends StatefulWidget {
  @override
  _LogHeaderState createState() => _LogHeaderState();
}

class _LogHeaderState extends State<LogHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 42,
      padding: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        // 分割线
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
        // color: Colors.red,
      ),
      child: IndexedStack(
        index: 0,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(''),
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
    return BaseBtn(
      text: '搜索',
      onPressed: () {
        setState(() {});
      },
    );
  }

  /// 清空日志按钮组件
  Widget clearBtnWidget() {
    return BaseBtn(
      text: '清空',
      onPressed: () {
        setState(() {
          jhDebug.clearPrintLog();
          JhUtils.toastTips('清空成功');
        });
      },
    );
  }
}
