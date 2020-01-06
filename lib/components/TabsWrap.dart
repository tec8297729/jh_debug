import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_debug/interface/main_interface.dart';
import 'package:jh_debug/utils/utls.dart';
import '../jh_debug.dart';
import 'BottomWrap.dart';

class TabsWrap extends StatefulWidget {
  TabsWrap({
    this.customBottomWidge,
    this.btnTap1,
    this.btnTitle1,
    this.btnTap2,
    this.btnTitle2,
    this.btnTap3,
    this.btnTitle3,
    this.hideBottom = false,
    this.hideCustomTab = true,
    this.customTabWidget,
    this.customTabTitle,
    this.tabsInitIndex,
  });

  /// 是否隐藏底部区域块,当为ture隐藏时,bottomWidge自定义底部区域将无效
  final bool hideBottom;

  /// 自定义底部区域组件,如果定义此参数默认定义的底部组件不显示
  final Widget customBottomWidge;

  /// 是否隐藏自定义tabs栏,默认true隐藏
  final bool hideCustomTab;

  /// 自定义tabs显示的组件
  final Widget customTabWidget;

  /// 自定义tabs的标题
  final String customTabTitle;

  /// 底部按钮1(开发) 点击事件
  final VoidCallback btnTap1;

  /// 底部按钮1 标题,
  final String btnTitle1;

  /// 底部按钮2(调试) 点击事件
  final VoidCallback btnTap2;

  /// 底部按钮2 标题,
  final String btnTitle2;

  /// 底部按钮3(生产) 点击事件
  final VoidCallback btnTap3;

  /// 底部按钮3 标题,
  final String btnTitle3;

  /// 每次弹窗口显示tabs页面
  final int tabsInitIndex;

  @override
  _TabsWrapState createState() => _TabsWrapState();
}

class _TabsWrapState extends State<TabsWrap> with TickerProviderStateMixin {
  TabController _tabController;
  List<Widget> tabViewChild = [];
  int tabsIndex = 0;
  int tapPrintLogIndex; // 当前print日志点击索引

  @override
  void initState() {
    super.initState();
    _initTabsWidget(initialIndex: widget.tabsInitIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    _tabController.dispose();
    super.dispose();
  }

  /// 更新tabs组件页面
  _initTabsWidget({int initialIndex}) {
    _tabController?.removeListener(tabListener);
    setState(() {
      // print数据源
      List<String> printLogList = jhDebug.getPrintLogAll;
      // print('dhyw>>>45${printLogList}');

      tabViewChild = [
        _logWrap(
          headerChild: _headerPrintLog(),
          child: [
            for (var i = printLogList.length; i > 0; i--)
              _logContext(
                index: i, // 倒序索引
                logData: '${printLogList[i - 1]}',
              )
          ],
        ),
        // 调试日志
        _logWrap(
          headerChild: _headerDebugLog(),
          child: [...handelDebugWidge()],
        ),
        if (!widget.hideCustomTab)
          Center(
            child: Text('自定义你显示的内容'),
          ),
      ];

      int tabsLen = tabViewChild.length; // tabs总长度
      if (initialIndex != null && initialIndex >= tabsLen) {
        initialIndex = tabsLen - 1;
      }
      _tabController = TabController(
        length: tabsLen,
        initialIndex: initialIndex ?? tabsIndex,
        vsync: this,
      );

      _tabController.addListener(tabListener);
    });
  }

  // 监听滑动事件
  tabListener() => tabsIndex = _tabController.index;

  /// 处理debug日志结构
  handelDebugWidge() {
    List<Map<D_Name, String>> debugLogList = jhDebug.getDebugLogAll;
    List<Widget> allWidget = [];

    for (var i = debugLogList.length; i > 0; i--) {
      String logData = debugLogList[i - 1][D_Name.log];
      String logStackData = debugLogList[i - 1][D_Name.stack];
      if (jhDebug.debugModeFull && logStackData != 'null')
        logData += '\n${logStackData}';

      allWidget.add(
        _logContext(
          index: i, // 倒序索引
          logData: logData,
        ),
      );
    }

    // if (allWidget.length <= 0) {
    //   allWidget.add(Center(
    //     heightFactor: 10,
    //     child: Text('真机调试状态下error捕获内容'),
    //   ));
    // }

    return allWidget;
  }

  /// 复制当前点击元素文本内容
  copyClickItemData(int index) {
    switch (_tabController.index) {
      case 0:
        // print日志
        List<String> printLogList = jhDebug.getPrintLogAll;
        copyFn(printLogList[index]);
        break;
      case 1:
        // debug日志
        List<Map<D_Name, String>> debugLogList = jhDebug.getDebugLogAll;
        copyFn(debugLogList[index].toString());
        break;
      default:
    }
  }

  /// 复制到系统剪切板
  copyFn(String textData) {
    Clipboard.setData(ClipboardData(text: textData));
    toastTips('已复制');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: <Widget>[
          // tab选项卡
          Container(
            height: 40,
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                _tabTitle('print'),
                _tabTitle('调试日志'),
                if (!widget.hideCustomTab) _tabTitle('自定义'),
              ],
            ),
          ),
          // tab显示内容区域
          Expanded(
            flex: 1,
            child:
                TabBarView(controller: _tabController, children: tabViewChild),
          ),

          // 底部区域
          if (!widget.hideBottom)
            BottomWrap(
              btnTap1: widget.btnTap1,
              btnTap2: widget.btnTap2,
              btnTap3: widget.btnTap3,
              initTabsWidget: _initTabsWidget,
              customBottomWidge: widget.customTabWidget,
            ),
        ],
      ),
    );
  }

  /// tab切换标题
  _tabTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.black),
    );
  }

  /// 基础log布局层
  _logWrap({@required List<Widget> child, Widget headerChild}) {
    return Stack(
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
    );
  }

  /// print日志头部组件
  Widget _headerPrintLog() {
    String tips = '';
    if (tapPrintLogIndex != null)
      switch (_tabController.index) {
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
          Container(child: Text('点击行: ${tips ?? ''}')),
          clearBtnWidget(),
        ],
      ),
    );
  }

  /// 调试日志头部组件
  Widget _headerDebugLog() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 3),
      height: 36,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          baseBtnWrap(
            text: jhDebug.debugModeFull ? '详细模式' : '精简模式',
            onPressed: () {
              jhDebug.debugModeFull = !jhDebug.debugModeFull;
              _initTabsWidget();
            },
          ),
          SizedBox(width: 10),
          clearBtnWidget(),
        ],
      ),
    );
  }

  /// 清空日志按钮组件
  Widget clearBtnWidget() {
    return baseBtnWrap(
      text: '清空',
      onPressed: () {
        switch (_tabController.index) {
          case 0:
            jhDebug.clearPrintLog();
            toastTips('已清空print日志');
            tapPrintLogIndex = null;
            _initTabsWidget();
            break;
          case 1:
            jhDebug.clearDebugLog();
            toastTips('已清空debug调试日志');
            tapPrintLogIndex = null;
            _initTabsWidget();
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
            child: Text('$index：'),
          ),
          // 右侧 错误日志内容区
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                copyClickItemData(index); // 处理数据复制
                tapPrintLogIndex = index;
                _initTabsWidget();
              },
              child: Text(logData.toString()),
            ),
          )
        ],
      ),
    );
  }
}
