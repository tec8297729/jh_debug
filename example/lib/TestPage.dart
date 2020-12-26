import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:jh_debug_example/services/api.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Stream<int> streamPrint;
  int index = 0;
  bool isEnabledFlag = true;

  @override
  void initState() {
    super.initState();
  }

  onBtn1() {
    setState(() {
      ++index;
      print('点击第一个按钮$index');
    });
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
  }

  @override
  Widget build(BuildContext context) {
    jhDebug.init(
      context: context,
      hideCustomTab: false,
      btnTap1: onBtn1,
      btnTap2: () {
        print('${jhDebug.getPrintLogAll}');
      },
      customTabTitle: '自定义tab专栏',
      customTabWidget: Container(
        child: Text('data'),
      ),
      // customBottomWidge: Container(
      //   child: Text('自定义按钮区域'),
      // ),
      recordEnabled: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('jhDebug Plugin'),
      ),
      body: Wrap(
        alignment: WrapAlignment.center, //沿主轴方向居中
        spacing: 18.0, // 每个组件之间的间隔
        runSpacing: 4.0, // 纵轴Y的间隔距离，每个组件底部间隔
        children: <Widget>[
          ...listBtns(),
        ],
      ),
    );
  }

  Widget baseBtn({String text, VoidCallback onPressed}) {
    return Container(
      child: RaisedButton(
        child: Text(text),
        onPressed: onPressed,
      ),
    );
  }

  testW() {
    return;
  }

  List<Widget> listBtns() {
    return [
      baseBtn(
        text: '全局btn$index',
        onPressed: () {
          jhDebug.showDebugBtn();
        },
      ),
      baseBtn(
        text: 'remove全局btn',
        onPressed: () {
          jhDebug.removeDebugBtn();
        },
      ),
      baseBtn(
        text: '调试窗口',
        onPressed: () {
          print('点击一次');
          jhDebug.showLog();
        },
      ),
      baseBtn(
        text: '打印N次',
        onPressed: () async {
          Duration interval = Duration(milliseconds: 30);
          streamPrint = Stream.periodic(interval, (data) => data);
          streamPrint = streamPrint.take(200);
          await for (int i in streamPrint) {
            print(
                'Test Log$i >>> ${DateTime.now().microsecondsSinceEpoch}dadfABCadfabckdyyablwefbcladAbcBcabcABCower');
          }
        },
      ),
      baseBtn(
        text: '常规error错误',
        onPressed: () {
          throw "Sample for exception";
          // Future.error("error自定义错误");
        },
      ),
      baseBtn(
        text: '手动error错误',
        onPressed: () async {
          Duration interval = Duration(seconds: 1);
          streamPrint = Stream.periodic(interval, (data) => data);
          streamPrint = streamPrint.take(10);
          await for (int i in streamPrint) {
            // print('测试打印${i}');
            jhDebug.setDebugLog(
              debugLog:
                  'RangeError (index$i): Invalid value: Not in range 0..3, inclusive: 4, D_',
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
          }
        },
      ),
      baseBtn(
        text: '下一页',
        onPressed: () {
          Navigator.pushNamed(context, '/detailsPage');
        },
      ),
      baseBtn(
        text: '${isEnabledFlag ? '禁用' : '启用'}log记录',
        onPressed: () {
          setState(() {
            jhDebug.setRecordEnabled(!isEnabledFlag);
            print(!isEnabledFlag);
            isEnabledFlag = !isEnabledFlag;
          });
        },
      ),
      baseBtn(
        text: 'get请求',
        onPressed: () {
          getNewVersion();
        },
      ),
    ];
  }
}
