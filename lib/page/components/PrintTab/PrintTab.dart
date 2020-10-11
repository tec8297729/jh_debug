import 'package:flutter/material.dart';
import 'package:jh_debug/utils/utls.dart';
import 'package:jh_debug/jh_debug.dart';
import '../BaseLogContext/BaseLogContext.dart';
import 'components/LogHeader.dart';

class PrintTab extends StatefulWidget {
  @override
  _PrintTabState createState() => _PrintTabState();
}

class _PrintTabState extends State<PrintTab> {
  int currentIdx = 0;

  // 复制当前点击元素文本内容
  void copyClickItemData(int dataIndex) async {
    List<String> printLogList = jhDebug.getPrintLogAll;
    await JhUtils.copyText(printLogList[dataIndex - 1]);
    setState(() {
      currentIdx = dataIndex;
    });
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentIdx = 0;
    // print("oldWidget>>${Widget.canUpdate(oldWidget, widget)}");
  }

  @override
  Widget build(BuildContext context) {
    List<String> dataList = jhDebug.getPrintLogAll;
    return BaseLogContext(
      headerChild: LogHeader(),
      child: [
        for (var i = dataList.length; i > 0; i--)
          _logTableItem(
            index: i, // 倒序索引
            logData: '${dataList[i - 1]}',
          )
      ],
    );
  }

  /// 日志输出布局item
  Widget _logTableItem({@required int index, @required String logData}) {
    TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 14);
    bool isCurrentIndex = currentIdx == index;

    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.all(7),
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
        color: isCurrentIndex
            ? Color.fromRGBO(222, 222, 222, 0.7)
            : Colors.transparent,
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
                copyClickItemData(index); // 处理数据复制
              },
              child: Text(logData.toString(), style: _textStyle),
            ),
          )
        ],
      ),
    );
  }
}
