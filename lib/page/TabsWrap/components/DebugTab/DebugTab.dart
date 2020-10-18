import 'package:flutter/material.dart';
import 'package:jh_debug/components/BaseLogContext/BaseLogContext.dart';
import 'package:jh_debug/components/logItem/logItem.dart';
import 'package:jh_debug/utils/utls.dart';
import 'package:jh_debug/jh_debug.dart';
import 'components/LogHeader.dart';

class DebugTab extends StatefulWidget {
  @override
  _DebugTabState createState() => _DebugTabState();
}

class _DebugTabState extends State<DebugTab>
    with AutomaticKeepAliveClientMixin {
  int currentIdx = 0;
  @override
  bool get wantKeepAlive => true;
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
    List<Map<String, String>> dataList = jhDebug.getDebugLogAll;
    List<Widget> allWidget = [];

    for (var i = dataList.length; i > 0; i--) {
      String logData = JhUtils.getItemDebugLogStr(dataList[i - 1]);

      allWidget.add(LogItem(
        index: i, // 倒序索引
        currentIdx: currentIdx,
        logData: logData,
        onTap: onTapLog,
      ));
    }
    return BaseLogContext(
      headerChild: LogHeader(),
      child: allWidget,
    );
  }
}
