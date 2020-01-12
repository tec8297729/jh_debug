import 'package:fluttertoast/fluttertoast.dart';

import '../jh_debug.dart';

class JhUtils {
  /// tosat提示
  static toastTips(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER, // 提示位置
      fontSize: 18, // 提示文字大小
    );
  }

  /// 获取当前调试日志信息str
  static getItemDebugLogStr(Map<D_Name, String> itemData) {
    String logData = itemData[D_Name.log];
    String logStackData = itemData[D_Name.stack];
    if (jhDebug.debugModeFull && logStackData != 'null') {
      logData += '\n$logStackData';
    }
    return logData;
  }
}
