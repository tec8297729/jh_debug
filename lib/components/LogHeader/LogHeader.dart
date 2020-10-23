import 'package:flutter/material.dart';
import 'package:jh_debug/components/BaseBtn/BaseBtn.dart';
import 'package:jh_debug/config/jh_config.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug/types/index.dart';
import 'package:jh_debug/utils/logData_utls.dart';
import 'package:jh_debug/utils/utls.dart';

/// 日志内容区头部组件
class LogHeader extends StatefulWidget {
  LogHeader({Key key, @required this.logType}) : super(key: key);
  final LogType logType;

  @override
  _LogHeaderState createState() => _LogHeaderState();
}

class _LogHeaderState extends State<LogHeader> {
  TextEditingController _textController = TextEditingController();
  SearchStatus searchStatus = SearchStatus.hide; // 是否显示搜索
  bool isShowClearIcon = false;
  final FocusNode _focusNode = FocusNode(); // 光标
  final double inputHeight = 42.0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isShowClearIcon = true;
        });
        return;
      }
      setState(() {
        isShowClearIcon = false;
      });
    });
  }

  @override
  void dispose() {
    noFocusInput();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void noFocusInput() {
    _focusNode.requestFocus();
    _focusNode.unfocus(); // 取消焦点
  }

  // 搜索按钮事件
  void onSearchBtn(String text) {
    logDataUtls.setSearch(sKey: text, type: widget.logType);
  }

  // 回退按钮
  void goBackHeader() {
    setState(() {
      noFocusInput();
      logDataUtls.setSearch(sKey: '', type: widget.logType);
      searchStatus = SearchStatus.hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: inputHeight,
      padding: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        // 分割线
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
        color: Colors.white,
      ),
      child: IndexedStack(
        index: searchStatus == SearchStatus.show ? 1 : 0, // 层级
        children: <Widget>[
          widget.logType == LogType.print ? _printBtnBase() : _debugBtnBase(),
          searchBoxW(), // 搜索条1
        ],
      ),
    );
  }

  // print头基础按钮
  Widget _printBtnBase() {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Text('')),
        searchBtnW(),
        clearBtnW(),
      ],
    );
  }

  // debug头基础按钮
  Widget _debugBtnBase() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        searchBtnW(),
        BaseBtn(
          text: jhConfig.debugModeFull ? '精简' : '详细',
          onPressed: () {
            setState(() {
              jhConfig.debugModeFull = !jhConfig.debugModeFull;
              logDataUtls.flushDebug();
            });
          },
        ),
        SizedBox(width: 10),
        clearBtnW(),
      ],
    );
  }

  // 组合搜索icon按钮
  Widget searchBtnW() {
    return Container(
      margin: EdgeInsets.only(right: 3),
      child: IconButton(
        icon: Icon(Icons.search),
        iconSize: 22,
        color: Color(0xFF1C88E5), // 图标颜色
        onPressed: () {
          setState(() {
            searchStatus = SearchStatus.show;
          });
        },
        tooltip: '搜索',
      ),
    );
  }

  // 清空日志按钮组件
  Widget clearBtnW() {
    return BaseBtn(
      text: '清空',
      onPressed: () {
        if (widget.logType == LogType.print) {
          jhDebug.clearPrintLog();
        } else {
          jhDebug.clearDebugLog();
        }
        setState(() {
          JhUtils.toastTips('清空成功');
        });
      },
    );
  }

  // 搜索框组件
  Widget searchBoxW() {
    return Container(
      height: inputHeight,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            iconSize: 15,
            color: Colors.black87,
            onPressed: goBackHeader,
            tooltip: '回退',
          ),
          Expanded(
            flex: 1,
            child: searchInput(),
          ),
          // 右侧清空icon
          if (isShowClearIcon)
            iconBtn(
              icons: Icons.close,
              color: Colors.black45,
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  logDataUtls.setSearch(sKey: '', type: widget.logType);
                  _textController.clear();
                });
              },
            ),
          // 搜索icon
          iconBtn(
            icons: Icons.search,
            onPressed: () {
              noFocusInput();
              onSearchBtn(_textController.text);
            },
          ),
        ],
      ),
    );
  }

  // 搜索右侧icon基础组件按钮
  Widget iconBtn({
    IconData icons,
    VoidCallback onPressed,
    Color color,
  }) {
    return Container(
      width: 30,
      child: IconButton(
        icon: Icon(
          icons,
          color: color ?? null,
        ),
        iconSize: 18,
        color: Color(0xFF1C88E5),
        onPressed: onPressed,
      ),
    );
  }

  // 搜索输入框
  Widget searchInput() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: inputHeight),
      child: TextField(
        controller: _textController,
        focusNode: _focusNode, // 控制输入框焦点
        onSubmitted: onSearchBtn, // 回车事件
        textInputAction: TextInputAction.search,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: '输入搜索关键字',
          hintStyle: TextStyle(color: Colors.black38),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
