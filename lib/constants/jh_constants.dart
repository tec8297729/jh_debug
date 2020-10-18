import '../interface/main_interface.dart';

class JhConstants {
  static const PrintLogKey = 'jhPrintLogKey';
  static const DebugLogKey = 'jhDebugLogKey';
  static const ERROR_TIPS_PREFIX = 'jh_debug错误：';

  /// print日志数量
  static const int PRINT_RECORD = 50;

  /// 调试日志数量
  static const int DEBUG_RECORD = 30;

  /// 默认tabs索引
  static const int TABS_INIT_INDEX = 0;

  /// 是否完整输出调试日志
  static const bool DEBUG_MODEFULL = true;

  /// 弹窗内容区是否可以左右滑动
  static const bool SCROLL_FLAG = false;

  /// 是否错误输出在控制台
  static const DebugMode ISIN_DEBUGMODE = DebugMode.inConsole;

  /// 是否记用记录log
  static const RECORD_ENABLED = true;
}
