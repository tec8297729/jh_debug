import 'package:dio/dio.dart';
import '../utils/dio/safeRequest.dart';

/// 获取APP最新版本号, 演示更新APP组件
Future<Map> getNewVersion([String version]) async {
  Map resData = await safeRequest(
    'https://www.fastmock.site/mock/4fa6906a0c87f7c2513e85cb98eb4bdb/shop/nCoV/api/area',
    options: Options(method: 'GET'), // 请求类型
  );
  print('请示后》》》');

  return resData ?? {};
}
