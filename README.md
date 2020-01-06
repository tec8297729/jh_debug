# jh_debug

debug调试器工具，让你的开发更便捷！简单易用快速上手。
当纯真机调试时，更友好的捕获错误日志输出。

> * 自动捕获错误及print相关信息，无需复杂配置。
> * 可定义组件内调试窗口内
> * 内置自定义按钮事件，更好扩展业务功能，例如：切换不同开发环境接口

## 快速入门
1、在main.dart入口处添加如下代码

```dart
import 'package:jh_debug/jh_debug.dart';
void main() {
  jhDebugMain(
    appChild: MyApp(),
    // 你的各项捕获参数配置
    debugMode: DebugMode.inConsole,
    errorCallback: (error){}, // 错误回调函数
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: jhDebug.getNavigatorKey, // 绑定Key
      // ...其它参数
    );
  }
}

```

<br>

2、在MaterialApp的home中的页面设置初始化参数
```dart
// 建议在initState阶段执行一次即可
jhDebug.init(
  // 指定默认调试窗口内的一些参数配置
  btnTitle1: '按钮1', // 定义按钮名称
  btnTap1: () {}, // 定义按钮触发事件
);

init参数介绍
[btnTap1, btnTap2, btnTap3] 定义底部按钮点击事件

[btnTitle1, btnTitle2, btnTitle3] 定义底部按钮的标题

[tabsInitIndex] 弹出窗口时,指定显示tabs页面, 默认每次弹出显示第0个tabs

[hideCustomTab] 是否隐藏自定义tabs栏,默认true隐藏

[customTabTitle] 自定义区域tabs的标题

[customTabWidget] 自定义区域tabs显示的组件

[hideBottom] 是否隐藏底部区域块,当为ture隐藏时,bottomWidge自定义底部区域将无效

[customBottomWidge] 底部区域组件,如果定义此参数默认定义的底部组件不显示

[printRecord] print日志最多记录多少条,默认50条

[debugRecord] 调试日志最多记录多少条,默认30条
```
<br>

3、调用调试工具，在你需要使用到的页面
```dart
jhDebug.showLog(); // 弹出jhDebug调试窗口
```

其它相关API
```dart
// 手动添加一条print日志
jhDebug.setPrintLog('错误'); 

// 手动添加一条debug调试日志
jhDebug.setDebugLog(
  debugLog: 'debugError错误',
  debugStack: 'stack信息',
);
```

个人博客 www.jonhuu.com