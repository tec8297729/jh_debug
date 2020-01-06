import 'package:jh_debug/interface/main_interface.dart';

class JhConfig {
  /// print日志数量
  static const int PRINT_RECORD = 50;

  /// 调试日志数量
  static const int DEBUG_RECORD = 30;

  /// 默认tabs索引
  static const int TABS_INIT_INDEX = 0;

  /// 是否完整输出调试日志
  static const bool DEBUG_MODEFULL = true;

  /// 是否错误输出在控制台
  static const DebugMode ISIN_DEBUGMODE = DebugMode.inConsole;
}
