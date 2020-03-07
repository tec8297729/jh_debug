import '../constants/jh_constants.dart';

class JhConfig {
  /// 是否详细模式输出错误日志，默认true
  bool debugModeFull = JhConstants.DEBUG_MODEFULL;

  /// print日志上限
  int printRecord = JhConstants.PRINT_RECORD;

  /// debug日志上限
  int debugRecord = JhConstants.DEBUG_RECORD;

  /// 测试输出
  bool trace = true;
}

JhConfig jhConfig = JhConfig();
