import 'package:flutter/material.dart';
import 'package:jh_debug/constants/index.dart' show textDefalutStyle;

/// 日志单个item组件
class LogItem extends StatefulWidget {
  const LogItem({
    Key? key,
    required this.index,
    required this.currentIdx,
    required this.logData,
    required this.onTap,
    this.customRChild,
  }) : super(key: key);

  final int index;
  final int currentIdx;
  final String logData;
  final void Function(int idx) onTap;
  final Widget? customRChild;

  @override
  _LogItemState createState() => _LogItemState();
}

class _LogItemState extends State<LogItem> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _logTableItem(
        index: widget.index,
        logData: widget.logData,
      ),
    );
  }

  /// 日志输出布局item
  Widget _logTableItem({required int index, required String logData}) {
    bool isCurrentIndex = widget.currentIdx == index;

    return InkWell(
      onTap: () {
        widget.onTap(index); // 处理数据复制
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(10, 13, 10, 13),
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
              child: Text('$index：', style: textDefalutStyle),
            ),
            // 右侧 错误日志内容区
            Expanded(
              flex: 1,
              child: widget.customRChild ??
                  Text(logData.toString(), style: textDefalutStyle),
            )
          ],
        ),
      ),
    );
  }
}
