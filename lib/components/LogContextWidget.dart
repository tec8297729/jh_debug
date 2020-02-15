import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utls.dart';
import '../config/jh_config.dart' show jhConfig;
import '../jh_debug.dart';

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

class _LogContextWidgetState extends State<LogContextWidget> {
  /// 当前print日志点击索引
  int tapPrintLogIndex;
  Color _textColor = Colors.black;
  Color _bgColor = Colors.white;

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

  @override
  Widget build(BuildContext context) {
    if (widget.logType == LogType.print) {
      return _logWrap(
        headerChild: _headerPrintLog(),
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
      headerChild: _headerDebugLog(),
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
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 43, 5, 5),
              child: Column(children: <Widget>[...child]),
            ),
          ),
          // 头部组件
          if (headerChild != null)
            headerChild,
        ],
      ),
    );
  }

  /// print日志头部组件
  Widget _headerPrintLog() {
    String tips = '';
    if (tapPrintLogIndex != null)
      switch (widget.getTabContrIdx()) {
        case 0:
          tips = 'print-$tapPrintLogIndex';
          break;
        case 1:
          tips = 'debug-$tapPrintLogIndex';
          break;
        default:
      }
    return Container(
      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
      height: 36,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              '点击行: ${tips ?? ''}',
              style: TextStyle(color: _textColor),
            ),
          ),
          clearBtnWidget(),
        ],
      ),
    );
  }

  /// debug调试日志头部组件
  Widget _headerDebugLog() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 3),
      height: 36,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          baseBtnWrap(
            text: jhConfig.debugModeFull ? '详细模式' : '精简模式',
            onPressed: () {
              jhConfig.debugModeFull = !jhConfig.debugModeFull;
              widget.initTabsWidget();
            },
          ),
          SizedBox(width: 10),
          clearBtnWidget(),
        ],
      ),
    );
  }

  /// 日志输出布局item
  Widget _logContext({@required int index, @required String logData}) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
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
            child: Text(
              '$index：',
              style: TextStyle(color: _textColor),
            ),
          ),
          // 右侧 错误日志内容区
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                copyClickItemData(index - 1); // 处理数据复制
                tapPrintLogIndex = index;
                widget.initTabsWidget();
              },
              child: Text(
                logData.toString(),
                style: TextStyle(color: _textColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 清空日志按钮组件
  Widget clearBtnWidget() {
    return baseBtnWrap(
      text: '清空',
      onPressed: () {
        switch (widget.getTabContrIdx()) {
          case 0:
            jhDebug.clearPrintLog();
            JhUtils.toastTips('已清空print日志');
            tapPrintLogIndex = null;
            widget.initTabsWidget();
            break;
          case 1:
            jhDebug.clearDebugLog();
            JhUtils.toastTips('已清空debug调试日志');
            tapPrintLogIndex = null;
            widget.initTabsWidget();
            break;
          default:
        }
      },
    );
  }

  /// 按钮基础层
  Widget baseBtnWrap(
      {@required String text, @required VoidCallback onPressed}) {
    return Container(
      width: 90,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 14)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
