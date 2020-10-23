import 'package:flutter/material.dart';
import 'package:jh_debug/components/BaseLogContext/BaseLogContext.dart';
import 'package:jh_debug/components/LogHeader/LogHeader.dart';
import 'package:jh_debug/components/SearchItem/SearchItem.dart';
import 'package:jh_debug/components/logItem/logItem.dart';
import 'package:jh_debug/types/index.dart';
import 'package:jh_debug/utils/logData_utls.dart';
import 'package:jh_debug/utils/utls.dart';
import 'package:jh_debug/jh_debug.dart';

class DebugTab extends StatefulWidget {
  @override
  _DebugTabState createState() => _DebugTabState();
}

class _DebugTabState extends State<DebugTab>
    with AutomaticKeepAliveClientMixin {
  int currentIdx = 0;
  @override
  bool get wantKeepAlive => true;
  final LogType _logType = LogType.debug;
  // item点击事件
  void onTapLog(int index) {
    List<Map<String, String>> debugLogList = jhDebug.getDebugLogAll;
    JhUtils.copyText(JhUtils.getItemDebugLogStr(debugLogList[index - 1]));
    setState(() {
      currentIdx = index;
    });
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentIdx = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BaseLogContext(
      headerChild: LogHeader(logType: _logType),
      child: handleLogItem(),
    );
  }

  List<Widget> handleLogItem() {
    List<Map<String, String>> dataList = jhDebug.getDebugLogAll;
    List<Widget> allWidget = [];

    final sKey = logDataUtls.getSearchKey(_logType);

    if (sKey.isNotEmpty) {
      return handleSearchItem(dataList, sKey);
    }

    for (var i = dataList.length; i > 0; i--) {
      String logData = JhUtils.getItemDebugLogStr(dataList[i - 1]);

      allWidget.add(LogItem(
        index: i, // 倒序索引
        currentIdx: currentIdx,
        logData: logData,
        onTap: onTapLog,
      ));
    }
    return allWidget;
  }

  // 生成搜索高亮组件
  List<Widget> handleSearchItem(
    List<Map<String, String>> dataList,
    String sKey,
  ) {
    List<Widget> tabList = [];
    RegExp reg = new RegExp(
      r"(" + sKey + ")",
      multiLine: true,
      caseSensitive: false,
    );

    for (var i = dataList.length; i > 0; i--) {
      String logData = JhUtils.getItemDebugLogStr(dataList[i - 1]);
      if (reg.hasMatch(logData)) {
        tabList.add(LogItem(
          index: i, // 倒序索引
          currentIdx: currentIdx,
          logData: logData,
          onTap: onTapLog,
          customRChild: SearchItem(text: logData, type: _logType),
        ));
      }
    }
    return tabList;
  }
}
