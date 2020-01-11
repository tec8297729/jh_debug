import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jh_debug/constants/index_constants.dart';
import './index.dart';
import 'interface/main_interface.dart';

export 'interface/main_interface.dart';

/// log挂载方法
JhDebug jhDebug = JhDebug();

/// main入口函数修饰器
///
/// [appChild] runApp()内的页面组件
///
/// [debugMode] 错误信息是否输出在控制台, 默认true, 生产环境建议使用flase
///
/// [errorCallback] 错误回调函数,返回错误相关信息,自定义上报错误等信息
///
/// [beforeAppChildFn] 构建appChild之前钩子函数
///
/// ```dart
/// void main() {
///   jhDebugMain(
///     appChild: MyApp(),
///   );
/// }
///
/// // 另外需要绑定全局key
/// MaterialApp(
///   navigatorKey: jhDebug.getNavigatorKey,
/// )
/// ```
jhDebugMain({
  @required Widget appChild,
  Function(FlutterErrorDetails) errorCallback,
  VoidCallback beforeAppChildFn,
  DebugMode debugMode = JhConfig.ISIN_DEBUGMODE,
}) {
  if (debugMode != DebugMode.self) {
    FlutterError.onError = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };
  }

  /// zone错误回调函数
  zoneErrorFlagFn(
    DebugMode debugMode,
    Function(FlutterErrorDetails) errorCallback,
  ) {
    // 调用原生错误输出模式
    if (debugMode == DebugMode.self) return null;

    return (Object obj, StackTrace stack) {
      /// 错误信息
      FlutterErrorDetails details = (Object obj, StackTrace stack) {
        jhDebug.setDebugLog(
          debugLog: obj.toString(),
          debugStack: stack.toString(),
        );
        return FlutterErrorDetails(
          exception: obj,
          stack: stack,
          library: 'Flutter JH_DEBUG',
        );
      }(obj, stack);

      // print('错误层>>>');
      if (debugMode == DebugMode.inConsole) {
        FlutterError.dumpErrorToConsole(details);
      }

      // 自定义上报错误
      if (errorCallback != null) errorCallback(details);
    };
  }

  return runZoned(
    () {
      if (beforeAppChildFn != null) beforeAppChildFn();
      return runApp(appChild);
    },
    zoneSpecification: new ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        jhDebug.setPrintLog(line);
        parent.print(self, "$line");
      },
    ),
    onError: zoneErrorFlagFn(debugMode, errorCallback),
  );
}
