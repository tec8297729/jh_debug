import 'package:fluttertoast/fluttertoast.dart';
import '../config/jh_config.dart' show jhConfig;

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
  static getItemDebugLogStr(Map<String, String> itemData) {
    String logData = itemData['debugLog'];
    String logStackData = itemData['debugStack'];
    if (jhConfig.debugModeFull && logStackData != 'null') {
      logData += '\n$logStackData';
    }
    return logData;
  }
}
