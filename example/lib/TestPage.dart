import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    jhDebug.init(
      context: context,
      hideCustomTab: true,
      btnTap1: () {
        print('点击第一个按钮');
      },
      // btnTitle1: '测试按钮',
    );
  }

  showDebugBtn() {
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.7,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.bug_report), // 设置按钮icon图标
          backgroundColor: Colors.pink, // 按钮的背景颜色
          mini: false, // 是否是小图标
          elevation: 10, // 未点击时的阴影值
          highlightElevation: 20, // 点击状态时的阴影值
        ),
      );
    });
    Overlay.of(context).insert(overlayEntry);
    print('${Overlay.of(context).toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('jhDebug Plugin'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('全局btn'),
              onPressed: () {
                jhDebug.showDebugBtn();
                // showDebugBtn();
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('remove全局btn'),
              onPressed: () {
                jhDebug.removeDebugBtn();
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('调试窗口'),
              onPressed: () {
                print('点击一次');
                jhDebug.showLog();
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('打印一次'),
              onPressed: () {
                print('测试打印${DateTime.now()}');
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('添加常规error错误'),
              onPressed: () {
                // _tabController = TabController(length: 1, vsync: this);
                throw "Sample for exception";
                // Future.error("error自定义错误");
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('手动添加error错误'),
              onPressed: () {
                jhDebug.setDebugLog(
                  debugLog:
                      'RangeError (index): Invalid value: Not in range 0..3, inclusive: 4, D_',
                  debugStack:
                      '''List.[] (dart:core-patch/growable_array.dart:149:60)
#1      _TabsWrapState.copyClickItemData (package:jh_debug/components/TabsWrap.dart:170:28)
#2      _TabsWrapState._logContext.<anonymous closure> (package:jh_debug/components/TabsWrap.dart:356:17)
#3      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:182:24)
#4      TapGestureRecognizer.handleTapUp (package:flutter/src/gestures/tap.dart:486:11)
#5      BaseTapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:264:5)
#6      BaseTapGestureRecognizer.acceptGesture (package:flutter/src/gestures/tap.dart:236:7)
#7      GestureArenaManager.sweep (package:flutter/src/gestures/arena.dart:156:27)
#8      GestureBinding.handleEvent (package:flutter/src/gestures/binding.dart:222:20)
#9      GestureBinding.dispatchEvent (package:flutter/src/gestures/binding.dart:198:22)
#10     GestureBinding._handlePointerEvent (package:flutter/src/gestures/binding.dart:156:7)
#11     GestureBinding._flushPointerEventQueue (package:flutter/src/gestures/binding.dart:102:7)
#12     GestureBinding._handlePointerDataPacket (package:flutter/src/gestures/binding.dart:86:7)
#13     _rootRunUnary (dart:async/zone.dart:1138:13)
#14     _CustomZone.runUnary (dart:async/zone.dart:1031:19)
#15     _CustomZone.runUnaryGuarded (dart:async/zone.dart:933:7)
#16     _invoke1 (dart:ui/hooks.dart:273:10)
#17     _dispatchPointerDataPacket (dart:ui/hooks.dart:182:5)
''',
                );
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('下一页'),
              onPressed: () {
                Navigator.pushNamed(context, '/detailsPage');
              },
            ),
          ),
          // Center(
          //   child: RaisedButton(
          //     child: Text('清空缓存'),
          //     onPressed: () {
          //       jhDebug.clearDebugLog();
          //       jhDebug.clearPrintLog();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
