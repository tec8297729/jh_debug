import 'package:flutter_test/flutter_test.dart';
import 'package:jh_debug_example/main.dart';

void main() {
  testWidgets('StackPosBtn浮动按钮测试', (WidgetTester tester) async {
    const labelStr = 'jhdebug_StackPosBtn';
    // 显示的UI组件
    await tester.pumpWidget(MyApp());

    // 全局浮层按钮
    await tester.tap(find.text('全局btn'));
    await tester.pump();
    expect(find.bySemanticsLabel(labelStr), findsOneWidget);

    // 子页面测试全局浮层按钮
    await tester.tap(find.text('下一页'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel(labelStr)); // 点击浮动按钮
    await tester.pumpAndSettle(Duration(seconds: 5));
    expect(find.bySemanticsLabel('jhdebug_TabsWrap'), findsOneWidget);
  });
}
