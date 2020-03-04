import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './components/LogHeader.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/utils/utls.dart';

enum LogType { debug, print }

/// 打印日志结构组件
class LogContextWidget extends StatefulWidget {
  LogContextWidget({
    @required this.dataList,
    @required this.initTabsWidget,
    @required this.logType,
    this.getTabContrIdx,
  });
  final Function initTabsWidget;

  /// 日志数据源
  final List dataList;

  /// 日志类型
  final LogType logType;

  /// tab控制器当前索引
  final int Function() getTabContrIdx;

  @override
  _LogContextWidgetState createState() => _LogContextWidgetState();
}

class _LogContextWidgetState extends State<LogContextWidget>
    with AutomaticKeepAliveClientMixin {
  /// 当前print日志点击索引
  int tapLogIndex;
  Color _textColor = Colors.black;
  Color _bgColor = Colors.white;
  ScrollController scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(keepScrollOffset: true);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// 处理debug日志结构
  handelDebugWidge() {
    List<Map<String, String>> debugLogList = jhDebug.getDebugLogAll;
    List<Widget> allWidget = [];

    for (var i = debugLogList.length; i > 0; i--) {
      String logData = JhUtils.getItemDebugLogStr(debugLogList[i - 1]);

      allWidget.add(
        _logContext(
          index: i, // 倒序索引
          logData: logData,
        ),
      );
    }
    return allWidget;
  }

  /// 复制当前点击元素文本内容
  copyClickItemData(int dataIndex) {
    switch (widget.getTabContrIdx()) {
      case 0:
        // print日志
        List<String> printLogList = jhDebug.getPrintLogAll;
        copyFn(printLogList[dataIndex]);
        break;
      case 1:
        // debug日志
        List<Map<String, String>> debugLogList = jhDebug.getDebugLogAll;
        copyFn(JhUtils.getItemDebugLogStr(debugLogList[dataIndex]));
        break;
      default:
    }
  }

  /// 复制到系统剪切板
  copyFn(String textData) async {
    await Clipboard.setData(ClipboardData(text: textData)).catchError((e) {
      JhUtils.toastTips('复制失败');
    });
    JhUtils.toastTips('已复制');
  }

  /// 设置tap点击索引
  setTapIndex([int index]) {
    if (index != null) {
      tapLogIndex = index;
    } else {
      tapLogIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.logType == LogType.print) {
      return _logWrap(
        headerChild: LogHeader(
          type: LogType.print,
          tapLogIndex: tapLogIndex,
          setTapIndex: setTapIndex,
          getTabContrIdx: widget.getTabContrIdx,
        ),
        child: [
          for (var i = widget.dataList.length; i > 0; i--)
            _logContext(
              index: i, // 倒序索引
              logData: '${widget.dataList[i - 1]}',
            )
        ],
      );
    }

    // 调试日志
    return _logWrap(
      headerChild: LogHeader(
        type: LogType.debug,
        tapLogIndex: tapLogIndex,
        setTapIndex: setTapIndex,
        getTabContrIdx: widget.getTabContrIdx,
      ),
      child: [...handelDebugWidge()],
    );
  }

  /// 基础log布局层
  _logWrap({@required List<Widget> child, Widget headerChild}) {
    return Container(
      color: _bgColor,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 43, 5, 5),
              child: Column(children: child),
            ),
          ),
          // 头部组件
          if (headerChild != null)
            headerChild,
        ],
      ),
    );
  }

  /// 日志输出布局item
  Widget _logContext({@required int index, @required String logData}) {
    TextStyle _textStyle = TextStyle(color: _textColor, fontSize: 14);

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
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
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  copyClickItemData(index - 1); // 处理数据复制
                  tapLogIndex = index;
                });
              },
              child: Text(logData.toString(), style: _textStyle),
            ),
          )
        ],
      ),
    );
  }
}