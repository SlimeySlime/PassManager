// import 'dart:d';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

const String passTable = 'passfolder';
const String columnId = '_id';
const String columnName = 'name';

class PassFolder {
  int id;
  String name;

  PassFolder({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {columnId: id, columnName: name};
  }

  Map<String, dynamic> toJson() {
    return {columnId: id, columnName: name};
  }

  factory PassFolder.fromJson(Map<String, dynamic> json) {
    return PassFolder(
      id: json[columnId],
      name: json[columnName],
    );
  }
}

class PassFolderProviderOld {
  static final PassFolderProviderOld instance =
      PassFolderProviderOld._instance();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    await _initDatabase();
    throw Error();
  }

  // use by PassFolderProviderOld.instance - 싱글턴
  PassFolderProviderOld._instance() {
    _initDatabase();
  }

  // PassFolderProviderOld() 를 지원
  factory PassFolderProviderOld() {
    return instance;
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'passfolder.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $passTable (
            $columnId INTEGER PRIMARY KEY autoincrement,
            $columnName TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static insert() {}

  // Future<List<Map<String, dynamic>>> getAll() async {
  //   return await _database.query(passTable);
  // }

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
}
