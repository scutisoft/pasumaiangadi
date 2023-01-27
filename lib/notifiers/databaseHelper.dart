import 'dart:async';
import 'dart:developer';

import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../model/jsonMasterModel.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper _databaseHelper = DatabaseHelper._();
//
//   DatabaseHelper._();
//
//   Database? db;
//
//   factory DatabaseHelper() {
//     return _databaseHelper;
//   }
//   Future<Database?> get database async {
//     if (db != null) {
//       return db;
//     }
//     db = await initDB();
//     return db;
//   }
//   Future initDB() async {
//     String path = await getDatabasesPath();
//     db = await openDatabase(
//       join(path, 'rms.db'),
//       onCreate: (database, version) async {
//         await database.execute(
//           """
//             CREATE TABLE jsonmaster (
//               JsonMasterId INTEGER PRIMARY KEY,
//               JsonIdentifier TEXT NOT NULL,
//               JsonPage TEXT NOT NULL,
//               IsActive INTEGER NOT NULL,
//               TempKey TEXT NOT NULL
//             )
//           """,
//         );
//       },
//       version: 1,
//     );
//     return db;
//   }
//
//   Future<int> insertJsonMaster(Map<String,dynamic> jsonMaster) async {
//     db=await database;
//     int result = await db!.insert('jsonmaster', jsonMaster);
//     return result;
//   }
//
//   Future<int> updateJsonMaster(Map<String,dynamic>  jsonMaster) async {
//     db=await database;
//     int result = await db!.update(
//       'jsonmaster',
//       jsonMaster,
//       where: "TempKey = ?",
//       whereArgs: [jsonMaster['TempKey']],
//     );
//     return result;
//   }
// Future getJsonPage(String tempKey) async {
//     db=await database;
//     List<Map> maps = await db!.query('jsonmaster', where: 'TempKey = ?', whereArgs: [tempKey]);
//
//     /*db!.query('jsonmaster', where: 'TempKey = ?', whereArgs: [tempKey]).then((value){
//       if(value.isNotEmpty){
//         return JsonMaster.fromMap(value[0]);
//       }
//      // return null;
//     });*/
//
//     if (maps.isNotEmpty) {
//       // log(" ${JsonMaster.fromMap(maps.first)}");
//       return JsonMaster.fromMap(maps.first);
//     }
//     return null;
//   }
//
//   Future<List<JsonMaster>> retrieveJsonMasters() async {
//     db=await database;
//     final List<Map<String, Object?>> queryResult = await db!.query('jsonmaster');
//     return queryResult.map((e) => JsonMaster.fromMap(e)).toList();
//   }
//
//   Future<void> deleteJsonMaster(int id) async {
//     db=await database;
//     await db!.delete(
//       'jsonmaster',
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }
//
// }