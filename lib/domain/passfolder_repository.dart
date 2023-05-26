import 'package:passmanager/domain/passfolder.dart';

class PassFolderRepository {
  static Future<PassFolder> create(PassFolder folder) async {
    var db = await PassFolderProviderOld().database;
    db.insert(passTable, folder.toMap());
    return folder;
  }

  static Future<List<Map<String, dynamic>>> getAll(PassFolder folder) async {
    var db = await PassFolderProviderOld().database;
    return await db.query(passTable);
  }

  // static Future<List<PassFolder>> getAllJson(PassFolder folder) async {
  //   var db = await PassFolderProviderOld().database;
  //   var result = await db.query(passTable);
  //   return result.map((data) {
  //     return PassFolder.fromJson(data);
  //   }).toList();
  // }
}

// Future<PassFolder> insert(PassFolder folder) async {
//   folder.id = await _database.insert(passTable, folder.toMap());
//   return folder;
// }

// Future<int> delete(int id) async {
//   return await _database
//       .delete(passTable, where: '$columnId = ?', whereArgs: [id]);
// }

// Future<int> update(PassFolder folder) async {
//   return await _database.update(passTable, folder.toMap(),
//       where: '$columnId = ?', whereArgs: [folder.id]);
// }
