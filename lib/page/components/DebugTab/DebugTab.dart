import 'package:flutter/material.dart';
import 'package:jh_debug/utils/utls.dart';
import 'package:jh_debug/jh_debug.dart';
import '../BaseLogContext/BaseLogContext.dart';
import 'components/LogHeader.dart';

class DebugTab extends StatefulWidget {
  @override
  _DebugTabState createState() => _DebugTabState();
}

class _DebugTabState extends State<DebugTab> {
  // 复制当前点击元素文本内容
  void copyClickItemData(int dataIndex) {
    List<Map<String, String>> debugLogList = jhDebug.getDebugLogAll;
    JhUtils.copyText(JhUtils.getItemDebugLogStr(debugLogList[dataIndex]));
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> dataList = jhDebug.getDebugLogAll;
    List<Widget> allWidget = [];

    for (var i = dataList.length; i > 0; i--) {
      String logData = JhUtils.getItemDebugLogStr(dataList[i - 1]);

      allWidget.add(
        _logTableItem(
          index: i, // 倒序索引
          logData: logData,
        ),
      );
    }
    return BaseLogContext(
      headerChild: LogHeader(),
      child: allWidget,
    );
  }

  /// 日志输出布局item
  Widget _logTableItem({@required int index, @required String logData}) {
    TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 14);

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        // 分割线
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: (index != 1)
                ? Colors.primaries[(index + 3) % Colors.primaries.length]
                    .withOpacity(0.4)
                : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          // 左侧
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 20, maxWidth: 54),
            child: Text('$index：', style: _textStyle),
          ),
          // 右侧 错误日志内容区
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                copyClickItemData(index - 1); // 处理数据复制
              },
              child: Text(logData.toString(), style: _textStyle),
            ),
          )
        ],
      ),
    );
  }
}
