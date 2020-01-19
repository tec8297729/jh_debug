# jh_debug

debug调试器工具，让你的开发更便捷处理bug！简单易用快速上手。
当真机调试时，更友好的捕获错误日志输出。

> * 自动捕获错误及print相关信息，无需复杂配置。
> * 带有全局捕获error回调钩子，可自定义上报错误日志
> * 可自定义组件内调试窗口内按钮事件，更好扩展业务功能，例如：切换不同开发环境接口
> * 内置全局浮动按钮组件

<div style="display:flex; justify-content: space-evenly;">
<img src="https://github.com/tec8297729/jh_debug/blob/master/images/demo_1.png?raw=true" width="340px">
<img src="https://github.com/tec8297729/jh_debug/blob/master/images/demo_2.png?raw=true" width="340px">
</div>

## 快速入门

### 第一步：
1、在main.dart入口处添加如下代码

```dart
import 'package:jh_debug/jh_debug.dart';
void main() {
  jhDebugMain(
    appChild: MyApp(),
    debugMode: DebugMode.inConsole, // 错误映射到插件中，纯真机模式可设置成none模式
    errorCallback: (error){}, // 错误回调函数
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: jhDebug.getNavigatorKey, // 绑定key
    );
  }
}
```
<br>

### 第二步：

2、在MaterialApp的home页面设置init初始化参数
```dart
import 'package:jh_debug/jh_debug.dart';

// 初始化，建议在initState阶段执行一次即可
jhDebug.init(
  context: context,
  // 指定默认调试窗口内的一些参数配置
  btnTitle1: '按钮1', // 定义按钮名称
  btnTap1: () {}, // 定义按钮触发事件
);
```
<br>

jhDebug.init参数介绍
<br>

|              参数               |   类型   |                               说明                                |
| :-----------------------------: | :------: | :---------------------------------------------------------------: |
|    btnTap1, btnTap2, btnTap3    | Function |                       弹层底部按钮点击事件                        |
| btnTitle1, btnTitle2, btnTitle3 |  String  |                         弹层底部按钮标题                          |
|          tabsInitIndex          |   int    |      弹出窗口时,指定显示tabs页面, 默认每次弹出显示第0个tabs       |
|          hideCustomTab          |   bool   |                 是否隐藏自定义tabs栏,默认true隐藏                 |
|         customTabTitle          |  String  |                       自定义区域tabs的标题                        |
|         customTabWidget         |  Widget  |                     自定义区域tabs显示的组件                      |
|           hideBottom            |   bool   | 是否隐藏底部区域块,当为ture隐藏时,bottomWidge自定义底部区域将无效 |
|        customBottomWidge        |  Widget  |        底部区域组件,如果定义此参数默认定义的底部组件不显示        |
|           printRecord           |   int    |                 print日志最多记录多少条,默认50条                  |
|           debugRecord           |   int    |                  调试日志最多记录多少条,默认30条                  |

<br>

### 第三步：

3、调用调试工具，在你需要使用到的页面

```dart
jhDebug.showLog(); // 弹出jhDebug调试窗口，可自己指定义绑定到某个按钮事件上
jhDebug.hideLog(); // 隐藏jhDebug调试窗口

jhDebug.showDebugBtn(); // 显示全局浮动按钮，此按钮已内置点击显示出jeDebug调试弹层, 双击隐藏自身按钮, 长按拖动按钮位置
jhDebug.removeDebugBtn(); // 隐藏全局按钮
```

其它相关API<br>

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