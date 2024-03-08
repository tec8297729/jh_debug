import 'package:flutter/material.dart';
import 'package:jh_debug/components/BottomWrap/BottomWrap.dart';
import 'package:jh_debug/config/jh_config.dart';
import 'package:jh_debug/types/index.dart' show CustomTabItem, LogType;
import 'package:jh_debug/utils/logData_utls.dart';
import 'components/DebugTab/DebugTab.dart';
import 'components/PrintTab/PrintTab.dart';

/// 弹层组件
class TabsWrap extends StatefulWidget {
  TabsWrap(
      {this.customBottomWidge,
      this.btnTap1,
      this.btnTitle1,
      this.btnTap2,
      this.btnTitle2,
      this.btnTap3,
      this.btnTitle3,
      this.hideBottom,
      this.hideCustomTab = true,
      this.tabsInitIndex,
      this.customTabs});

  /// 是否隐藏底部区域块,当为ture隐藏时,bottomWidge自定义底部区域将无效
  final bool? hideBottom;

  /// 自定义底部区域组件,如果定义此参数默认定义的底部组件不显示
  final Widget? customBottomWidge;

  /// 是否隐藏自定义tabs栏,默认true隐藏
  final bool? hideCustomTab;

  /// 自定义扩展tabs显示的组件
  final List<CustomTabItem>? customTabs;

  /// 底部按钮1(开发) 点击事件
  final VoidCallback? btnTap1;

  /// 底部按钮1 标题,
  final String? btnTitle1;

  /// 底部按钮2(调试) 点击事件
  final VoidCallback? btnTap2;

  /// 底部按钮2 标题,
  final String? btnTitle2;

  /// 底部按钮3(生产) 点击事件
  final VoidCallback? btnTap3;

  /// 底部按钮3 标题,
  final String? btnTitle3;

  /// 每次弹窗口显示tabs页面
  final int? tabsInitIndex;

  @override
  _TabsWrapState createState() => _TabsWrapState();
}

class _TabsWrapState extends State<TabsWrap>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  List<CustomTabItem> tabsData = [];
  int tabsIndex = 0;
  @override
  bool get wantKeepAlive => true;

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
  _initTabsWidget({int? initialIndex}) {
    tabsData = [
      // print日志
      CustomTabItem(title: 'print', widget: _logListStream(LogType.print)),
      // debug日志
      CustomTabItem(title: '调试日志', widget: _logListStream(LogType.debug)),
      // 网络监听
      // CustomTabItem(title: 'Network', widget: NetwrorkTab())
    ];

    widget.customTabs?.forEach((customTabItem) {
      tabsData.add(customTabItem);
    });

    int tabsLen = tabsData.length; // tabs总长度
    if (initialIndex != null && initialIndex >= tabsLen) {
      initialIndex = tabsLen - 1;
    }
    _tabController = TabController(
      length: tabsLen,
      initialIndex: initialIndex ?? tabsIndex,
      vsync: this,
    );

    _tabController.addListener(tabListener);
  }

  /// 监听滑动事件
  tabListener() {
    tabsIndex = _tabController.index;
    FocusScope.of(context).unfocus();
  }

  /// 获取tab索引
  int getTabContrIdx() => _tabController.index;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Semantics(
      label: 'jhdebug_TabsWrap',
      child: Container(
        height: 460,
        constraints: BoxConstraints(
          minWidth: 350,
          maxWidth: 800,
        ),
        child: Column(
          children: <Widget>[
            // tab选项卡
            Container(
              height: 40,
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorPadding: EdgeInsets.zero,
                tabAlignment: TabAlignment.start, // tab文字布局方式，默认居中开始
                isScrollable: tabsData.length > 3 ? true : false,
                tabs: <Widget>[...tabsData.map((e) => _tabTitle(e.title))],
              ),
            ),
            // tab显示内容区域
            Expanded(
              flex: 1,
              child: TabBarView(
                controller: _tabController,
                physics:
                    jhConfig.scrollFlag ? null : NeverScrollableScrollPhysics(),
                children:
                    tabsData.map((e) => _customTabList(e.widget)).toList(),
              ),
            ),

            // 底部区域
            if (widget.hideBottom != true)
              BottomWrap(
                btnTap1: widget.btnTap1,
                btnTap2: widget.btnTap2,
                btnTap3: widget.btnTap3,
                btnTitle1: widget.btnTitle1,
                btnTitle2: widget.btnTitle2,
                btnTitle3: widget.btnTitle3,
                customBottomWidge: widget.customBottomWidge,
              ),
          ],
        ),
      ),
    );
  }

  /// tab切换标题
  _tabTitle(String? title) {
    return Text(
      title ?? '',
      style: TextStyle(color: Colors.black, fontSize: 15),
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 自定义tab内容组件
  Widget _customTabList(Widget userWidget) {
    // ignore: unnecessary_null_comparison
    if (userWidget == null)
      return Center(
        child: Text('自定义你显示的内容'),
      );
    return userWidget;
  }

  /// 日志组件
  Widget _logListStream(LogType type) {
    bool isPrintW = type == LogType.print;
    return StreamBuilder(
      stream: isPrintW ? logDataUtls.subPrint() : logDataUtls.subDebug(),
      builder: (context, snap) => isPrintW ? PrintTab() : DebugTab(),
    );
  }
}
