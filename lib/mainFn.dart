import 'dart:async';
import 'package:flutter/material.dart';
import 'constants/jh_constants.dart';
import 'index.dart' show JhDebug; // jhDebug
import 'interface/main_interface.dart';

/// log挂载方法
JhDebug jhDebug = JhDebug();

/// main入口函数修饰器
///
/// [appChild] runApp()内的页面组件
///
/// [debugMode] 错误日志输出模式，self原生模式（部份错误日志不会被打印到插件中）,inConsole将错误日志映射到插件中（开启IDE情况下，ide控制台及插件同时有错误日志）, none不映射日志（真机上依然可以捕获）
///
/// [errorCallback] 错误回调函数,返回错误相关信息,自定义上报错误等信息
///
/// [beforeAppChildFn] 构建appChild之前钩子函数
/// ```
jhDebugMain({
  @required Widget appChild,
  Function(FlutterErrorDetails) errorCallback,
  VoidCallback beforeAppChildFn,
  DebugMode debugMode = JhConstants.ISIN_DEBUGMODE,
}) {
  if (debugMode != DebugMode.self) {
    FlutterError.onError = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };

    // ErrorWidget.builder = (FlutterErrorDetails details) {
    //   Zone.current.handleUncaughtError(details.exception, details.stack);
    //   String message = '';
    //   assert(() {
    //     String _stringify(Object exception) {
    //       try {
    //         return exception.toString();
    //       } catch (e) {
    //         // intentionally left empty.
    //       }
    //       return 'Error';
    //     }

    //     message = _stringify(details.exception) +
    //         '\nSee also: https://flutter.dev/docs/testing/errors';
    //     return true;
    //   }());
    //   final Object exception = details.exception;
    //   return ErrorWidget.withDetails(
    //       message: message,
    //       error: exception is FlutterError ? exception : null);
    // };
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
