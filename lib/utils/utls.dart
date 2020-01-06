import 'package:fluttertoast/fluttertoast.dart';

/// tosat提示
toastTips(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    // gravity: ToastGravity.CENTER, // 提示位置
    fontSize: 18, // 提示文字大小
  );
}
