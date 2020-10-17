import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/utils/utls.dart';
import '../../components/logItem/logItem.dart';
import '../BaseLogContext/BaseLogContext.dart';
import 'components/LogHeader.dart';

class PrintTab extends StatefulWidget {
  @override
  _PrintTabState createState() => _PrintTabState();
}

class _PrintTabState extends State<PrintTab> {
  int currentIdx = 0;

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
    List<String> dataList = jhDebug.getPrintLogAll;
    return BaseLogContext(
      headerChild: LogHeader(),
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
