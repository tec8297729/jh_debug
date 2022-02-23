import '../utils/request.dart';

/// 获取APP最新版本号, 演示更新APP组件
Future<Map> getNewVersion() async {
  var resData = await Request.get(
    'https://www.fastmock.site/mock/4fa6906a0c87f7c2513e85cb98eb4bdb/shop/nCoV/api/area?key=778',
    queryParameters: {
      'nono': 666,
      'hehe': 'szzq',
    },
  );
  print('请示后》》》');

  return resData ?? {};
}
