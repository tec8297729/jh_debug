import 'package:flutter/material.dart';
import 'components/TabsWrap.dart';
import 'constants/index_constants.dart';
import 'interface/main_interface.dart';

class JhDebug {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  Widget showWidget = TabsWrap();
  List<String> _printLogAll = []; // 所有print日志
  /// 调试日志
  List<Map<D_Name, String>> _debugLogAll = [
    // {
    //   D_Name.log: 'dsfdsf',
    //   D_Name.stack: 'dddddd',
    // }
  ];
  int printRecord = JhConfig.PRINT_RECORD;
  int debugRecord = JhConfig.DEBUG_RECORD;
  bool debugModeFull = JhConfig.DEBUG_MODEFULL;

  /// 初始化组件参数
  ///
  /// [btnTap1, btnTap2, btnTap3] 定义底部按钮点击事件
  ///
  /// [btnTitle1, btnTitle2, btnTitle3] 定义底部按钮的标题
  ///
  /// [tabsInitIndex] 弹出窗口时,指定显示tabs页面, 默认每次弹出显示第0个tabs
  ///
  /// [hideCustomTab] 是否隐藏自定义tabs栏,默认true隐藏
  ///
  /// [customTabTitle] 自定义区域tabs的标题
  ///
  /// [customTabWidget] 自定义区域tabs显示的组件
  ///
  /// [hideBottom] 是否隐藏底部区域块,当为ture隐藏时,bottomWidge自定义底部区域将无效
  ///
  /// [customBottomWidge] 底部区域组件,如果定义此参数默认定义的底部组件不显示
  ///
  /// [printRecord] print日志最多记录多少条,默认50条
  ///
  /// [debugRecord] 调试日志最多记录多少条,默认30条
  ///
  /// [debugModeFull] 调试日志中-是否显示详细日志, 默认flase精简日志, true详细日志
  init({
    bool hideCustomTab = true,
    Widget customTabWidget,
    String customTabTitle,
    bool hideBottom = false,
    Widget customBottomWidge,
    VoidCallback btnTap1,
    VoidCallback btnTap2,
    VoidCallback btnTap3,
    String btnTitle1,
    String btnTitle2,
    String btnTitle3,
    int printRecord = JhConfig.PRINT_RECORD,
    int debugRecord = JhConfig.DEBUG_RECORD,
    int tabsInitIndex = JhConfig.TABS_INIT_INDEX,
    bool debugModeFull = JhConfig.DEBUG_MODEFULL,
  }) {
    showWidget = TabsWrap(
      hideCustomTab: hideCustomTab,
      customTabWidget: customTabWidget,
      hideBottom: hideBottom,
      customBottomWidge: customBottomWidge,
      btnTap1: btnTap1,
      btnTap2: btnTap2,
      btnTap3: btnTap3,
      btnTitle1: btnTitle1,
      btnTitle2: btnTitle2,
      btnTitle3: btnTitle3,
      tabsInitIndex: tabsInitIndex,
    );

    printRecord = printRecord;
    debugRecord = debugRecord;
    debugModeFull = debugModeFull;
  }

  /// main入口MaterialApp中的key值
  GlobalKey<NavigatorState> get getNavigatorKey => navigatorKey;

  /// 获取调试栏log日志信息
  List<Map<D_Name, String>> get getDebugLogAll => _debugLogAll;

  /// 设置调试log日志内容, 输出flutter错误日志,构建错误等
  setDebugLog({@required String debugLog, @required String debugStack}) {
    if (_debugLogAll.length > debugRecord) {
      _debugLogAll.removeAt(0); // 清除多余日志
    }
    print('添加次数');

    _debugLogAll.add({
      D_Name.log: debugLog,
      D_Name.stack: debugStack,
    });
  }

  /// 清空所有调试debug日志
  void clearDebugLog() => _debugLogAll.clear();

  /// 获取print栏 最新的一条log日志信息
  String get getPrintLog => _printLogAll[_printLogAll.length - 1];

  /// 获取所有print栏 log日志信息
  List<String> get getPrintLogAll => _printLogAll;

  /// 设置print栏日志内容
  void setPrintLog(String text) {
    if (_printLogAll.length > printRecord) {
      _printLogAll.removeAt(0); // 清除多余日志
    }
    _printLogAll.add(text);
  }

  /// 清空所有print日志
  void clearPrintLog() => _printLogAll = [];

  /// 显示JhDebug窗口方法
  showLog() {
    final BuildContext _diglogCtx = navigatorKey.currentState.overlay.context;
    showDialog(
      context: _diglogCtx,
      builder: (BuildContext context) => Dialog(child: showWidget),
    );
  }
}
