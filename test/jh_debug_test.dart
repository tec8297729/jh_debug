import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jh_debug/jh_debug.dart';

void main() {
  const MethodChannel channel = MethodChannel('jh_debug');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await JhDebug.platformVersion, '42');
  // });
}
