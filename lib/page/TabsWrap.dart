import 'package:flutter/material.dart';
import 'package:jh_debug/utils/logData_utls.dart';
import 'components/LogContextWidget/LogContextWidget.dart';
import 'components/BottomWrap/BottomWrap.dart';
import '../jh_debug.dart';

/// 弹层组件
class TabsWrap extends StatefulWidget {
  TabsWrap({
    this.customBottomWidge,
    this.btnTap1,
    this.btnTitle1,
    this.btnTap2,
    this.btnTitle2,
    this.btnTap3,
    this.btnTitle3,
    this.hideBottom,
    this.hideCustomTab,
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

  @override
  void initState() {
    super.initState();
    _initTabsWidget(initialIndex: widget.tabsInitIndex);
  }

  @override
  void dispose() {
    _tabController?.removeListener(tabListener);
    _tabController?.dispose();
    super.dispose();
  }

  /// 更新tabs组件页面
  _initTabsWidget({int initialIndex}) {
    setState(() {
      _tabController?.removeListener(tabListener);
      tabViewChild = [
        _printList(), // print日志
        _debugList(), // debug日志
        if (!widget.hideCustomTab)
          _customTabList(),
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
  tabListener() {
    tabsIndex = _tabController.index;
  }

  /// 获取tab索引
  int getTabContrIdx() => _tabController.index;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'jhdebug_TabsWrap',
      child: Container(
        height: 400,
        child: Column(
          children: <Widget>[
            // tab选项卡
            Container(
              height: 40,
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                tabs: <Widget>[
                  _tabTitle('print'),
                  _tabTitle('调试日志'),
                  if (!widget.hideCustomTab)
                    _tabTitle(widget.customTabTitle ?? '自定义'),
                ],
              ),
            ),
            // tab显示内容区域
            Expanded(
              flex: 1,
              child: TabBarView(
                controller: _tabController,
                children: tabViewChild,
              ),
            ),

            // 底部区域
            if (!widget.hideBottom)
              BottomWrap(
                btnTap1: widget.btnTap1,
                btnTap2: widget.btnTap2,
                btnTap3: widget.btnTap3,
                btnTitle1: widget.btnTitle1,
                btnTitle2: widget.btnTitle2,
                btnTitle3: widget.btnTitle3,
                initTabsWidget: _initTabsWidget,
                customBottomWidge: widget.customBottomWidge,
              ),
          ],
        ),
      ),
    );
  }

  /// tab切换标题
  _tabTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.black, fontSize: 15),
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 自定义tab内容组件
  Widget _customTabList() {
    if (widget.customTabWidget == null)
      return Center(
        child: Text('自定义你显示的内容'),
      );
    return widget.customTabWidget;
  }

  /// print日志组件
  Widget _printList() {
    return StreamBuilder(
      stream: () {
        return logDataUtls.subPrint();
      }(),
      builder: (context, snap) {
        return LogContextWidget(
          logType: LogType.print,
          dataList: jhDebug.getPrintLogAll ?? [],
          getTabContrIdx: getTabContrIdx,
          initTabsWidget: _initTabsWidget,
        );
      },
    );
  }

  /// debug日志组件
  Widget _debugList() {
    return StreamBuilder(
      stream: () {
        return logDataUtls.subDebug();
      }(),
      builder: (context, snap) {
        return LogContextWidget(
          logType: LogType.debug,
          dataList: jhDebug.getDebugLogAll ?? [],
          getTabContrIdx: getTabContrIdx,
          initTabsWidget: _initTabsWidget,
        );
      },
    );
  }
}
