// import 'package:flutter/material.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

const String tablePassFolder = 'PassFolder';
const String columnId = '_id';
const String columnFolderName = 'folder_name';
const String columnFolderValue = 'folder_value';

class PassFolder {
  late int id;
  final String foldername;
  final String foldervalue;

  PassFolder(this.foldername, this.foldervalue);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnFolderName: foldername,
      columnFolderValue: foldervalue,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // PassFolder.fromMap(Map<String, Object?> map) {
  //   id = map[columnId];
  //   foldername = map[columnFolderName];
  // }
}

class FolderProvider {
  static const dbPathName = 'passfolder.db';
  static final FolderProvider instance = FolderProvider._instance();

  FolderProvider._instance() {
    initDatabase();
  }

  late Database db;

  Future<Database> get database async {
    if (db != null) return db;
    await initDatabase();
    return db;
  }

  // FolderProvider() 를 지원하는 factory
  // FolderProvider() == FolderProvider.instance
  // factory FolderProvider() {
  //   return instance;
  // }
  FolderProvider();

  Future initDatabase() async {
    var dbPath = join(await getDatabasesPath(), dbPathName);
    await deleteDatabase(dbPath);
    const createQuery = '''
          'CREATE TABLE $tablePassFolder (
            $columnId INTEGER PRIMEY KEY AUTOINCREMENT,
            $columnFolderName TEXT NOT NULL,
            $columnFolderValue TEXT
          )'
        ''';
    db = await openDatabase(dbPath,
        version: 1,
        onCreate: (db, version) async => {await db.execute(createQuery)});
    print('_init database at $dbPath');
    await insertRaw(PassFolder('folder test1', 'ok'));
    print('_init database and insert test');
  }

  Future close() async {
    await db.close();
  }

  Future insert(PassFolder passfolder) async {
    passfolder.id = await db.insert(tablePassFolder, passfolder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future insertRaw(PassFolder folder) async {
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $tablePassFolder ($columnFolderName, $columnFolderValue) VALUES ("?", ?)',
          [folder.foldername, folder.foldervalue]);
      print('inserting ${id1}');
    });
  }

  Future getPassFolder(String foldername) async {
    List<Map> list = await db.query(
      tablePassFolder,
      columns: [columnFolderName, columnFolderValue],
      where: '$columnFolderName LIKE ?',
      whereArgs: [foldername],
    );
    print(list);
    return list;
  }

  Future getAllPassFolder() async {
    List<Map> list = await db.query(
      tablePassFolder,
      columns: [columnFolderName, columnFolderValue],
    );
    if (list.isNotEmpty) {
      return list;
    } else {
      return null;
    }
  }

  Future getAllPassFolderRaw() async {
    List<Map> list = await db.rawQuery('SELECT * FROM $tablePassFolder');
    print('raw select passfolder $list');
    return list;
  }
}

// Future _opendb() async {
//   // final databasePath = await getData
//   final db = await OpenDynamicLibrary();
// }

// Future add(item) async {
//   final db = _opendb();
//   item.id = db.
// }
