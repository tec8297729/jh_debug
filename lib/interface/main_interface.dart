enum D_Name { log, stack }

class DebugLogType {
  String debugLog;
  String debugStack;
}

enum DebugMode {
  /// [self]模式 使用原生错误输出方式打印在控制台中，此模式不会捕获到更多错误在回调函数中，一般只有在定位不到错误，需要查看更完整的报错信息才开启此模式。
  self,

  /// [inConsole]模式 将内置错误输出到控制台中，并且错误捕获信息类型比较多，建议开发中使用。如果错误信息还定位不到错误，然后在尝试flutter模式
  inConsole,

  /// [none]模式 不会输出错误信息在控制台中，但会执行错误回调
  none,
}
