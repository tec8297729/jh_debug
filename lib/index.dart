import 'package:flutter/material.dart';
import 'package:jh_debug/utils/logData_utls.dart';
import 'components/StackPosBtn.dart';
import 'page/TabsWrap.dart';
import 'constants/jh_constants.dart';
import 'config/jh_config.dart' show jhConfig;

class JhDebug {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _layerFlag = false;
  Widget _layerWidget = TabsWrap(); // log弹层组件
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
    assert(context != null);
    assert(hideCustomTab != null);
    assert(hideBottom != null);
    // 初始化弹层日志组件
    _layerWidget = TabsWrap(
      hideCustomTab: hideCustomTab,
      customTabWidget: customTabWidget,
      customTabTitle: customTabTitle,
      tabsInitIndex: tabsInitIndex,
      hideBottom: hideBottom,
      customBottomWidge: customBottomWidge,
      btnTap1: btnTap1,
      btnTap2: btnTap2,
      btnTap3: btnTap3,
      btnTitle1: btnTitle1,
      btnTitle2: btnTitle2,
      btnTitle3: btnTitle3,
    );

    jhConfig.printRecord = printRecord;
    jhConfig.debugRecord = debugRecord;
    jhConfig.debugModeFull = debugModeFull;
    jhConfig.context = context;
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

  /// 获取调试栏所有log日志信息
  List<Map<String, String>> get getDebugLogAll => logDataUtls.getDebugLogAll;

  /// 设置调试log日志内容, 输出flutter错误日志,构建错误等
  setDebugLog({@required String debugLog, @required String debugStack}) {
    logDataUtls.addDebugLog(debugLog, debugStack);
  }

  /// 清空调试debug所有日志
  void clearDebugLog() => logDataUtls.clearDebug();

  /// 获取print栏 最新的一条log日志信息
  String get getPrintLog => logDataUtls.getPrintLog;

  /// 获取所有print栏 log日志信息
  List<String> get getPrintLogAll => logDataUtls.getPrintLogAll;

  /// 设置print栏日志内容
  void setPrintLog(String text) => logDataUtls.addPringLog(text);

  /// 清空print所有日志
  void clearPrintLog() => logDataUtls.clearPrint();

  /// 清空所有类型日志
  void clearAllLog() {
    clearDebugLog();
    clearPrintLog();
  }

  // 初始化init方法判断
  bool _judegInit() {
    if (_initFlag) return true;
    throw Exception('未初始化jeDebug.init方法');
    // return false;
  }

  /// 显示JhDebug弹层窗口
  showLog() {
    if (!_judegInit() || _layerFlag) return;
    _layerFlag = true;
    showGeneralDialog(
      context: getGlobalContext,
      barrierLabel: "jhDialog",
      barrierDismissible: true, // 是否点击其他区域消失
      barrierColor: Colors.black54, // 遮罩层背景色
      transitionDuration: Duration(milliseconds: 150), // 弹出的过渡时长
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(child: _layerWidget);
      },
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        // 显示的动画组件
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(animation),
          child: child,
        );
      },
    ).then((v) {
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
      throw Exception(
          'jhDebug错误：init方法中的context参数非法，请不要在MaterialApp组件中init初始化');
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
    }
  }
}
