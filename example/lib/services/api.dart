import '../models/common.m.dart';
import '../utils/request.dart';

/// 获取APP最新版本号, 演示更新APP组件
Future getNewVersion() async {
  var resData = await Request.get(
    'http://getman.cn/mock/route/to/demo',
    queryParameters: {
      'nono': 666,
      'hehe': 'szzq',
    },
  );
  print('请求后》》》$resData');

  return resData;
}
