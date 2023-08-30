import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FolderProvider with ChangeNotifier {
  // static final FolderRepository instance = FolderRepository._instance();

  static const String _tablePassFolder = 'PassFolder';
  static const String _columnId = 'id';
  static const String _columnFolderName = 'folder_name';
  static const String _columnFolderSubtitle = 'folder_subtitle';
  static const String _columnFolderValue = 'folder_value';
  static const String _columnFolderIconData = 'folder_Icon_data';
  static const String _columnFolderIconColor = 'folder_Icon_color';
  static const String _columnFolderColor = 'folder_color';

  static const _dbPathName = 'passfolder.db';

  late Database _db;

  late Map<String, PassFolder> _itemsMap = Map();
  late List<Map> _itemsList = [];

  List<Map> get items {
    return _itemsList;
  }
  // FolderRepository._instance() {
  //   open();
  // }

  // FolderRepository() == instance;
  // factory FolderRepository() {
  //   return instance;P
  // }

  Future<Database> get database async {
    // if (_db != null) return _db;P
    _db = await open();
    return _db;
  }

  // FutureOr<Void> _onUpgrade(Database db, int oldVer, int newVer) {}

  Future open() async {
    var _dbPath = join(await getDatabasesPath(), _dbPathName);
    const createQuery = '''
          'CREATE TABLE $_tablePassFolder (
            $_columnId INTEGER PRIMEY KEY AUTOINCREMENT,
            $_columnFolderName TEXT NOT NULL,
            $_columnFolderValue TEXT
          )'
        ''';

    _db = await openDatabase(
      _dbPath,
      version: 2,
      onCreate: (_db, version) async => {
        await _db.execute('''
            CREATE TABLE PassFolder (
              id INTEGER PRIMARY KEY, 
              $_columnFolderName TEXT NOT NULL, 
              $_columnFolderValue TEXT,
              $_columnFolderSubtitle TEXT,
              $_columnFolderIconData INTEGER,
              $_columnFolderIconColor TEXT,
              $_columnFolderColor TEXT );
          ''')
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          db.execute(
              'ALTER TABLE $_tablePassFolder ADD COLUMN $_columnFolderSubtitle TEXT');
          db.execute(
              'ALTER TABLE $_tablePassFolder ADD COLUMN $_columnFolderIconData INTEGER');
          db.execute(
              'ALTER TABLE $_tablePassFolder ADD COLUMN $_columnFolderIconColor TEXT');
          db.execute(
              'ALTER TABLE $_tablePassFolder ADD COLUMN $_columnFolderColor TEXT');
        }
      },
    );
    print('_init database at $_dbPath');
    notifyListeners();
    return _db;
  }

  Future<int> insert(PassFolder folder) async {
    print('to insert ${folder.folderName}');
    final db = await database;
    late int folderId;
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $_tablePassFolder ( $_columnFolderName, $_columnFolderValue ) VALUES (?, ?);',
          [folder.folderName, folder.folderSubtitle]);
      // return id1;
      folderId = id1;
    });

    _itemsList = await getAllPassFolder();
    notifyListeners();

    await db.close();
    return folderId;
    // print(result);
    // return result;
    // return await db.insert(_tablePassFolder, passfolder.toMap(),
    //     conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteFolder(int id) async {
    final db = await database;
    var result = await db
        .delete(_tablePassFolder, where: '$_columnId = ?', whereArgs: [id]);

    _itemsList = await getAllPassFolder();
    notifyListeners();
    return result;
  }

  Future getPassFolder(String foldername) async {
    final db = await database;
    List<Map> list = await db.query(
      _tablePassFolder,
      columns: [_columnFolderName, _columnFolderValue],
      where: '$_columnFolderName LIKE ?',
      whereArgs: [foldername],
    );
    print(list);
    return list;
  }

  // Future<List<Map>> getAllPassFolder() async {
  //   final db = await database;
  //   List<Map> list = await db.query(
  //     _tablePassFolder,
  //     columns: [_columnFolderName, _columnFolderValue],
  //   );
  //   print(list);
  //   return list;
  // }

  Future<List<Map>> getAllPassFolder() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $_tablePassFolder');
    print('get all passfolder $list');
    return list;
  }
}