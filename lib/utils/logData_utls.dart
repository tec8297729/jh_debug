import 'dart:async';
import 'package:jh_debug/config/jh_config.dart';
import 'package:jh_debug/types/index.dart';

List<String> _printLogAll = []; // 所有print日志
List<Map<String, String>> _debugLogAll = []; // 所有的debug调试日志
LogDataUtls logDataUtls = LogDataUtls()..init();

/// 数据源方法
class LogDataUtls {
  StreamController<List<String>> _printCtr = StreamController();
  late Stream<List<String>> _printStream; // print数据流
  StreamController<List<Map<String, String>>> _debugCtr = StreamController();
  late Stream<List<Map<String, String>>> _debugStream; // debug数据流
  // 搜索关键字
  Map<LogType, String> _searchKey = {
    LogType.debug: '',
    LogType.print: '',
  };

  /// 初始化实例
  void init() {
    _printStream = _printCtr.stream.asBroadcastStream();
    _debugStream = _debugCtr.stream.asBroadcastStream();
    // _printStream.listen((data) {
    //   return _printLogAll;
    // });
  }

  /// 订阅print日志
  Stream<List<String>> subPrint() => _printStream;

  /// 取消print订阅
  void unSubPrint() => _printCtr.close();

  /// 刷新print流数据
  void flushPrint() => _printCtr.sink.add(_printLogAll);

  /// 添加一条print日志
  void addPringLog(String data) {
    if (!jhConfig.recordEnabled) return;
    if (_printLogAll.length >= jhConfig.printRecord &&
        _printLogAll.length != 0) {
      // 清除多余日志
      _printLogAll.removeRange(
          0, _printLogAll.length - jhConfig.printRecord + 1);
    }
    _printLogAll.add(data);
    _printCtr.sink.add(_printLogAll);
  }

  /// print 获取单日志
  String get getPrintLog => _printLogAll[_printLogAll.length - 1];

  /// print 获取全部日志
  List<String> get getPrintLogAll {
    return _printLogAll;
  }

  /// 清空print日志数据
  void clearPrint() {
    _printLogAll = [];
    flushPrint();
  }

  // ---------------------  debug ------------------
  /// debug 日志订阅
  Stream<List<Map<String, String>>> subDebug() => _debugStream;

  /// debug 取消订阅
  void unSubDebug() => _debugCtr.close();

  /// debug 刷新流数据
  void flushDebug() => _debugCtr.sink.add(_debugLogAll);

  /// debug 添加一条日志
  void addDebugLog(String debugLog, String debugStack) {
    if (!jhConfig.recordEnabled) return;
    if (_debugLogAll.length >= jhConfig.debugRecord &&
        _debugLogAll.length != 0) {
      // 清除多余日志
      _debugLogAll.removeRange(
          0, _debugLogAll.length - jhConfig.debugRecord + 1);
    }
    _debugLogAll.add({
      'debugLog': debugLog,
      'debugStack': debugStack,
    });
    _debugCtr.sink.add(_debugLogAll);
  }

  /// debug单日志
  Map<String, String> get getDebugLog => _debugLogAll[_debugLogAll.length - 1];

  /// debug全部日志
  List<Map<String, String>> get getDebugLogAll => _debugLogAll;

  /// debug 清空日志
  void clearDebug() {
    _debugLogAll = [];
    flushDebug();
  }

  // ---------------------  搜索相关 ------------------
  /// 设置搜索内容
  void setSearch({required String sKey, required LogType type}) {
    _searchKey[type] = sKey;
    dyFlush(type);
  }

  /// 获取搜索关键
  String? getSearchKey(LogType type) {
    return _searchKey[type];
  }

  /// 清空所有搜索关键字
  void clearSearch() {
    _searchKey[LogType.debug] = '';
    _searchKey[LogType.print] = '';
  }

  /// 动态更新流
  void dyFlush(LogType type) {
    switch (type) {
      case LogType.print:
        flushPrint();
        break;
      case LogType.debug:
        flushDebug();
        break;
      default:
    }
  }
}
