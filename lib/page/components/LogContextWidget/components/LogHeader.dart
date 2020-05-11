import 'package:flutter/material.dart';
import 'package:jh_debug/config/jh_config.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/utils/logData_utls.dart';
import 'package:jh_debug/utils/utls.dart';
import '../LogContextWidget.dart';

/// 日志内容区头部组件
class LogHeader extends StatefulWidget {
  LogHeader({
    @required this.type,
    @required this.tapLogIndex,
    @required this.setTapIndex,
    @required this.getTabContrIdx,
  });
  final LogType type;

  /// 获取tap点击索引
  final int tapLogIndex;

  /// 设置tap索引
  final Function() setTapIndex;

  /// tab控制器当前索引
  final int Function() getTabContrIdx;

  @override
  _LogHeaderState createState() => _LogHeaderState();
}

class _LogHeaderState extends State<LogHeader> {
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    if (widget.type == LogType.debug) {
      return _headerDebugLog();
    }
    return _headerPrintLog();
  }

  /// print日志头部组件
  Widget _headerPrintLog() {
    String tips = '';
    if (widget.tapLogIndex != null) {
      switch (widget.getTabContrIdx()) {
        case 0:
          tips = 'print-${widget.tapLogIndex}';
          break;
        case 1:
          tips = 'debug-${widget.tapLogIndex}';
          break;
        default:
          break;
      }
    }

    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 3),
      height: 36,
      color: Colors.white,
      child: IndexedStack(
        index: 0,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  '点击行: ${tips ?? ''}',
                  style: TextStyle(color: _textColor),
                ),
              ),
              searchBtnWidget(),
              clearBtnWidget(),
            ],
          ),
          searchBtnWidget(),
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
      child: IndexedStack(
        index: 0,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              baseBtnWrap(
                text: jhConfig.debugModeFull ? '详细模式' : '精简模式',
                onPressed: () {
                  setState(() {
                    jhConfig.debugModeFull = !jhConfig.debugModeFull;
                    logDataUtls.flushDebug();
                  });
                },
              ),
              SizedBox(width: 10),
              clearBtnWidget(),
            ],
          ),
          // searchBtnWidget(),
        ],
      ),
    );
  }

  Widget searchBtnWidget() {
    return baseBtnWrap(
      text: '清空',
      onPressed: () {
        switch (widget.getTabContrIdx()) {
          case 0:
            jhDebug.clearPrintLog();
            JhUtils.toastTips(context, '已清空print日志');
            widget.setTapIndex();
            break;
          case 1:
            jhDebug.clearDebugLog();
            JhUtils.toastTips(context, '已清空debug调试日志');
            widget.setTapIndex();
            break;
          default:
        }
        setState(() {});
      },
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
            JhUtils.toastTips(context, '已清空print日志');
            widget.setTapIndex();
            break;
          case 1:
            jhDebug.clearDebugLog();
            JhUtils.toastTips(context, '已清空debug调试日志');
            widget.setTapIndex();
            break;
          default:
        }
        setState(() {});
      },
    );
  }

  /// 按钮基础层
  Widget baseBtnWrap(
      {@required String text, @required VoidCallback onPressed}) {
    return Container(
      // width: 90,
      child: RaisedButton(
        onPressed: onPressed,
        textColor: Colors.white,
        color: Color(0xFF1C88E5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
