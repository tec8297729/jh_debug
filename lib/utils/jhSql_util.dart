// import 'package:jh_debug/utils/utls.dart';
// import 'package:sqflite/sqflite.dart';

// SqlUtil sqlUtil = SqlUtil()..openDb();

// class SqlUtil {
//   final sqlFileName = 'jhDebug.sql'; // 数据库名
//   final _tablePrintName = 'table_print'; // 数据库表名
//   final _tableDebugName = 'table_debug'; // debug数据库表名
//   Database _db; // 数据库方法
//   Batch _batch;

//   // 打开数据库
//   Future openDb() async {
//     String path = "${await getDatabasesPath()}/$sqlFileName";
//     // 是否有数据库
//     if (_db == null) {
//       // print('创建数据库');
//       _db = await openDatabase(path, version: 2,
//           onCreate: (Database _db, int version) async {
//         JhUtils.toastTips('创建数据库');
//         /* 执行一段SQL语句(创建一张表)
//         id 整数型，不可重复，以key为键
//         dataId 整数型， title和body字段都是文本型
//         */
//         await _db.execute('''
//         CREATE TABLE $_tablePrintName (
//           id integer primary key,
//           dataId integer
//           log text
//         )
//         ''');
//         await _db.execute('''
//         CREATE TABLE $_tableDebugName (
//           id integer primary key,
//           dataId integer
//           log text
//           logStack text
//         )
//         ''');
//       });
//     }
//   }

//   // 插入数据库方法
//   Future insertDbPrint(List<String> data) async {
//     // int id = await _db.rawInsert(
//     //     'INSERT INTO $_tablePrintName(title, log) VALUES(?, ?, ?)',
//     //     ['another name', 12345678, 3.1416]);
//     if (_db == null) await openDb();
//     // deleteDb();
//     // _batch = _db.batch();
//     // for (var i = 0; i < data.length; i++) {
//     //   _batch.insert(_tablePrintName, {'log': data[i], 'dataId': i});
//     // }
//     // var results = await _batch.commit(); // 合并操作批量处理
//     // print(results.length);
//   }

//   // 查询pinrt数据库
//   Future<List<String>> queryDbPrint() async {
//     // 查询数据库方法(数据库名称, 指定查询条件-null为全部)
//     var resDb = await _db.query(_tablePrintName, columns: null);
//     List<String> data = [];
//     resDb.forEach((item) {
//       data.addAll(item['log']);
//     });
//     return data;
//   }

//   Future deleteDb() async {
//     var res = await _db.rawDelete("""
//     drop table $_tablePrintName
//     """);
//     // print(res.abs());
//   }
// }
