# 历史更新日志

## 2.0.1

> 修复顶部栏报错问题

## 2.0.0

> 调整jhDebug.init自定义tab组件参数及扩展能力，废弃参数：customTabTitle、customTabWidget，替换成customTabs参数

```dart
jhDebug.init(
  customTabs: [
    CustomTabItem(
      title: '自定义tab专栏',
      widget: Container(color: Colors.white, child: const Text('内容区1')),
    ),
    CustomTabItem(
      title: '自定义tab专栏2',
      widget: Container(color: Colors.white, child: const Text('内容区2')),
    ),
  ],
);
```

> jhDebugMain新增 beforeAppChildFn参数

## 1.0.2

> 修复flutter3空安全警告

## 1.0.1

> 修复类型问题

## 1.0.0

> sdk最低2.12.0兼容改造

## 0.5.0

> 针对dart2.8以上版本兼容改造

未来不兼容低版本dart，低于dart2.8版本的，请使用0.4.x版本插件

## 0.4.1

> 修复多次渲染bug

## 0.4.0

> 增加搜索功能
> 增加控制记录日志参数recordEnabled
> 重构部份功能提高性能

## 0.3.10

> 结构清余调整及优化

## 0.3.9

> 结构调整及文档手册更新

## 0.3.8

> 清除第三方依赖

## 0.3.6

> 修复调试日志中切换模式bug

## 0.3.5

> 弹层窗口新增动画
> 优化日志底层结构
> 修复自定义tab页面问题

## 0.3.3

> 修复样式显示

## 0.3.2

* 增加部份自定义扩展功能:

> 新增自定义全局key方法
> 新增获取全局context方法
> 新增自定义显示错误页面

## 0.3.1

> 新增全局key配置
> 修复bug视图嵌套过深问题

## 0.3.0

> 浮动按钮拖拽功能
> 优化部份细节功能

## 0.2.7

手机端debug调试插件
> 自动捕获错误及print相关信息，无需复杂配置。
> 可定义组件内调试窗口内
> 内置自定义按钮事件，更好扩展业务功能，例如：切换不同开发环境接口
