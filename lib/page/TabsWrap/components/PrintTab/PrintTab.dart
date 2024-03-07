import 'package:flutter/material.dart';
import 'package:jh_debug/components/BaseLogContext/BaseLogContext.dart';
import 'package:jh_debug/components/SearchItem/SearchItem.dart';
import 'package:jh_debug/components/logItem/logItem.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/utils/logData_utls.dart';
import 'package:jh_debug/utils/utls.dart';
import '../../../../components/LogHeader/LogHeader.dart';

class PrintTab extends StatefulWidget {
  @override
  _PrintTabState createState() => _PrintTabState();
}

class _PrintTabState extends State<PrintTab>
    with AutomaticKeepAliveClientMixin {
  int currentIdx = 0;
  @override
  bool get wantKeepAlive => true;
  final LogType _logType = LogType.print;

  // item点击事件
  onTapLog(int index) {
    List<String> printLogList = jhDebug.getPrintLogAll;
    JhUtils.copyText(printLogList[index - 1]);
    setState(() {
      currentIdx = index;
    });
  }

  // void didUpdateWidget(oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   currentIdx = 0;
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BaseLogContext(
      headerChild: LogHeader(logType: _logType),
      child: handleLogItem(),
    );
  }

  List<Widget> handleLogItem() {
    List<String> dataList = jhDebug.getPrintLogAll;
    List<Widget> tabList = [];
    final sKey = logDataUtls.getSearchKey(_logType);

    if (sKey != null) {
      return handleSearchItem(dataList, sKey);
    }

    for (var i = dataList.length; i > 0; i--) {
      tabList.add(LogItem(
        index: i, // 倒序索引
        currentIdx: currentIdx,
        logData: dataList[i - 1],
        onTap: onTapLog,
      ));
    }
    return tabList;
  }

  // 生成搜索高亮组件
  List<Widget> handleSearchItem(List<String> dataList, String sKey) {
    List<Widget> tabList = [];
    RegExp reg = new RegExp(
      r"(" + sKey + ")",
      multiLine: true,
      caseSensitive: false,
    );
    String currStr = '';
    for (var i = dataList.length; i > 0; i--) {
      currStr = dataList[i - 1];
      if (reg.hasMatch(currStr)) {
        tabList.add(LogItem(
          index: i, // 倒序索引
          currentIdx: currentIdx,
          logData: currStr,
          onTap: onTapLog,
          customRChild: SearchItem(text: currStr, type: _logType),
        ));
      }
    }
    return tabList;
  }
}
