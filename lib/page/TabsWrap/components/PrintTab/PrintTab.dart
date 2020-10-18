import 'package:flutter/material.dart';
import 'package:jh_debug/components/BaseLogContext/BaseLogContext.dart';
import 'package:jh_debug/components/logItem/logItem.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/types/index.dart';
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

  // item点击事件
  onTapLog(int index) {
    List<String> printLogList = jhDebug.getPrintLogAll;
    JhUtils.copyText(printLogList[index - 1]);
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
    List<String> dataList = jhDebug.getPrintLogAll;

    return BaseLogContext(
      headerChild: LogHeader(logType: LogType.print),
      child: [
        for (var i = dataList.length; i > 0; i--)
          LogItem(
            index: i, // 倒序索引
            currentIdx: currentIdx,
            logData: '${dataList[i - 1]}',
            onTap: onTapLog,
          )
      ],
    );
  }
}
