import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/jh_config.dart' show jhConfig;
import '../components/JhToast/JhToast.dart';

class JhUtils {
  /// tosat提示
  static void toastTips(String text, {BuildContext context}) {
    JhToast.showToast(jhConfig.context, msg: text);
    // Fluttertoast.showToast(
    //   msg: text,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
  }

  /// 复制到系统剪切板
  static void copyText(String textData, {BuildContext context}) {
    Clipboard.setData(ClipboardData(text: textData)).catchError((e) {
      JhUtils.toastTips('复制失败', context: context);
    });
    JhUtils.toastTips('已复制', context: context);
  }

  /// 获取当前调试日志信息str
  static String getItemDebugLogStr(Map<String, String> itemData) {
    String logData = itemData['debugLog'];
    String logStackData = itemData['debugStack'];
    if (jhConfig.debugModeFull && logStackData != 'null') {
      logData += '\n$logStackData';
    }
    return logData;
  }
}
