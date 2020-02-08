import 'package:flutter/material.dart';
import './components/StackPosBtn.dart';
import 'components/TabsWrap.dart';
import 'constants/jh_constants.dart';
import './utils/utls.dart';
import 'config/jh_config.dart' show jhConfig;

class JhDebug {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _layerFlag = false;
  Widget _layerWidget = TabsWrap(); // log弹层组件
  List<String> _printLogAll = []; // 所有print日志

  /// 调试日志
  List<Map<String, String>> _debugLogAll = [];
  int _printRecord = JhConstants.PRINT_RECORD;
  int _debugRecord = JhConstants.DEBUG_RECORD;
  // bool debugModeFull = JhConstants.DEBUG_MODEFULL;
  OverlayEntry _overlayEntry; // 叠加层组件
  int _overlayCode; // overlay_id
  bool _initFlag = false; // 初始化
  BuildContext _context;

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
  void init({
    @required BuildContext context,
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
    int printRecord = JhConstants.PRINT_RECORD,
    int debugRecord = JhConstants.DEBUG_RECORD,
    int tabsInitIndex = JhConstants.TABS_INIT_INDEX,
    bool debugModeFull = JhConstants.DEBUG_MODEFULL,
  }) async {
    _layerWidget = TabsWrap(
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
    jhConfig.debugModeFull = debugModeFull;
    _initFlag = true;
    _context = context;
  }

  /// 获取全局key
  GlobalKey<NavigatorState> get getNavigatorKey => _navigatorKey;

  /// 自定义全局key
  set setGlobalKey(GlobalKey<NavigatorState> _globalKey) =>
      _navigatorKey = _globalKey;

  /// 获取全局context
  BuildContext get getGlobalContext =>
      _navigatorKey?.currentState?.overlay?.context;

  /// 获取调试栏log日志信息
  List<Map<String, String>> get getDebugLogAll => _debugLogAll;

  /// 设置调试log日志内容, 输出flutter错误日志,构建错误等
  setDebugLog({@required String debugLog, @required String debugStack}) {
    if (_debugLogAll.length > _debugRecord) {
      _debugLogAll.removeAt(0); // 清除多余日志
    }

    _debugLogAll.add({
      'debugLog': debugLog,
      'debugStack': debugStack,
    });
  }

  /// 清空调试debug所有日志
  void clearDebugLog() => _debugLogAll.clear();

  /// 获取print栏 最新的一条log日志信息
  String get getPrintLog => _printLogAll[_printLogAll.length - 1];

  /// 获取所有print栏 log日志信息
  List<String> get getPrintLogAll => _printLogAll;

  /// 设置print栏日志内容
  void setPrintLog(String text) {
    if (_printLogAll.length > _printRecord) {
      _printLogAll.removeAt(0); // 清除多余日志
    }
    _printLogAll.add(text);
  }

  /// 清空print所有日志
  void clearPrintLog() => _printLogAll = [];

  /// 清空所有类型日志
  void clearAllLog() {
    clearDebugLog();
    clearPrintLog();
  }

  // 初始化init方法判断
  bool _judegInit() {
    if (_initFlag) return true;
    JhUtils.toastTips('未初始化jeDebug.init方法');
    return false;
  }

  /// 显示JhDebug弹层窗口
  showLog() {
    if (!_judegInit() || _layerFlag) return;
    _layerFlag = true;
    showDialog(
        context: getGlobalContext,
        builder: (context) {
          return Dialog(child: _layerWidget);
        }).then((v) {
      _layerFlag = false;
    });
  }

  /// 隐藏jhDebug弹层窗口
  hideLog() {
    if (!_judegInit()) return;
    try {
      Navigator.pop(getGlobalContext);
    } catch (e) {
      _layerFlag = false;
    }
  }

  /// 显示全局调试按钮，双击隐藏按钮
  ///
  /// [left, top, bottom, rigth] 可自定义按钮浮动显示的位置
  ///
  /// [width] 定义按钮的高度
  ///
  /// [height] 定义按钮的宽度
  showDebugBtn({
    double top,
    double bottom,
    double left,
    double rigth,
    double width,
    double height,
  }) {
    if (!_judegInit()) return;
    if (Overlay.of(_context) == null) {
      JhUtils.toastTips('错误：不支持添加，请不要在MaterialApp组件中直接使用');
      return;
    }
    if (_overlayCode != null) return;

    _overlayEntry = new OverlayEntry(
      builder: (context) {
        return StackPosBtn(
          width: width,
          height: height,
          top: top,
          bottom: bottom,
          left: left,
          rigth: rigth,
        );
      },
    );

    Overlay.of(_context).insert(_overlayEntry);
    _overlayCode = _overlayEntry.hashCode;
  }

  /// 隐藏全局调试按钮
  removeDebugBtn() {
    if (_overlayCode != null) {
      _overlayEntry.remove();
      _overlayCode = null;
      JhUtils.toastTips('已隐藏调试按钮');
    }
  }
}
