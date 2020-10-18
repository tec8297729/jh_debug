import 'package:flutter/material.dart';

import '../constants/jh_constants.dart';

class JhConfig {
  /// 是否详细模式输出错误日志，默认true
  bool debugModeFull = JhConstants.DEBUG_MODEFULL;

  /// print日志上限
  int printRecord = JhConstants.PRINT_RECORD;

  /// debug日志上限
  int debugRecord = JhConstants.DEBUG_RECORD;

  /// 是否左右滑动tab
  bool scrollFlag = JhConstants.SCROLL_FLAG;

  /// 局部上下文
  BuildContext context;

  /// 是否启用记录log，生产环境不常用时可默认设置关闭，手动调整开启
  bool recordEnabled = JhConstants.RECORD_ENABLED;
}

JhConfig jhConfig = JhConfig();
