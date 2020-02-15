// import 'package:sqflite/sqflite.dart';

// class SqlUtil {
//   final sqlFileName = 'jhDebug.sql'; // 数据库名
//   final tableDebugName = 'table_print'; // 数据库表名
//   final tablePrintName = 'table_debug'; // 数据库表名
//   Database db; // 暴露数据库变量，上面挂载了一系列操作数据库方法

//   // 自定义打开数据库
//   openDb() async {
//     String path = "${await getDatabasesPath()}/$sqlFileName";
//     // 是否有数据库
//     if (db == null) {
//       db = await openDatabase(path, version: 1,
//           onCreate: (Database db, int version) async {
//         // 创建完数据库后，会执行回调内语句...
//         // 执行一段SQL语句
//         /* (创建一张zzq_baseSql的表)
//         id 整数型，不可重复，以key为键
//         userid 整数型， title和body字段都是文本型
//         */
//         await db.execute('''
//         CREATE TABLE $tablePrintName (
//         id integer primary key,
//         userId integer,
//         title text,
//         body text
//         )
//         ''');
//       });
//     }
//   }
// }
