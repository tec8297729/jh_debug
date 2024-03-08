import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//// Toast 显示位置控制
enum ToastPostion {
  top,
  center,
  bottom,
}

class JhToast {
  /// toast靠它加到屏幕上
  static OverlayEntry? _overlayEntry;

  /// toast是否正在showing
  static bool _showing = false;

  /// 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static DateTime _startedTime = DateTime.now();

  /// 提示内容
  static String? _msg;

  /// toast显示时间
  static int? _showTime;

  /// 背景颜色
  static Color? _bgColor;

  /// 文本颜色
  static Color? _textColor;

  /// 文字大小
  static double? _textSize;

  /// 显示位置
  static ToastPostion? _toastPosition;

  /// 左右边距
  static double? _pdHorizontal;

  /// 上下边距
  static double? _pdVertical;
  static Future<bool> showToast(
    BuildContext context, {
    //显示的文本
    required String msg,
    //显示的时间 单位毫秒
    int showTime = 1000,
    //显示的背景
    Color bgColor = Colors.black,
    //显示的文本颜色
    Color textColor = Colors.white,
    //显示的文字大小
    double textSize = 14.0,
    //显示的位置
    ToastPostion position = ToastPostion.bottom,
    //文字水平方向的内边距
    double pdHorizontal = 20.0,
    //文字垂直方向的内边距
    double pdVertical = 10.0,
  }) async {
    _msg = msg;
    _startedTime = DateTime.now();
    _showTime = showTime;
    _bgColor = bgColor;
    _textColor = textColor;
    _textSize = textSize;
    _toastPosition = position;
    _pdHorizontal = pdHorizontal;
    _pdVertical = pdVertical;
    // 获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if (_overlayEntry == null) {
      // OverlayEntry负责构建布局
      // 通过OverlayEntry将构建的布局插入到整个布局的最上层
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          // top值，可以改变这个值来改变toast在屏幕中的位置
          top: buildToastPosition(context),
          child: Semantics(
            label: 'jhdebug_JhToast',
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: AnimatedOpacity(
                  opacity: _showing ? 0.7 : 0.0, // 目标透明度
                  duration: _showing
                      ? Duration(milliseconds: 100)
                      : Duration(milliseconds: 400),
                  child: _buildToastWidget(),
                ),
              ),
            ),
          ),
        ),
      );

      // 插入到整个布局的最上层
      overlayState.insert(_overlayEntry!);
    } else {
      _overlayEntry?.markNeedsBuild();
    }

    /// 等待时间
    await Future.delayed(Duration(milliseconds: _showTime!));
    // 2秒后消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= _showTime!) {
      _showing = false;
      _overlayEntry?.markNeedsBuild();
      await Future.delayed(Duration(milliseconds: 400));
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    return true;
  }

  // toast绘制
  static _buildToastWidget() {
    return Center(
      child: Card(
        color: _bgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _pdHorizontal!,
            vertical: _pdVertical!,
          ),
          child: Text(
            _msg!,
            style: TextStyle(fontSize: _textSize, color: _textColor),
          ),
        ),
      ),
    );
  }

  /// 设置toast位置
  static buildToastPosition(context) {
    var backResult;
    if (_toastPosition == ToastPostion.top) {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (_toastPosition == ToastPostion.center) {
      backResult = MediaQuery.of(context).size.height * 2 / 5;
    } else {
      backResult = MediaQuery.of(context).size.height * 8.5 / 10;
    }
    return backResult;
  }
}
