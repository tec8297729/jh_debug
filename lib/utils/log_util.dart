import 'package:jh_debug/config/jh_config.dart';

class LogUtil {
  static d(Object data) {
    if (jhConfig.trace) {
      print(data);
    }
  }
}
