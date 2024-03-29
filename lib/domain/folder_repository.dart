import 'dart:async';

import 'package:passmanager/domain/passfolder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FolderRepository {
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

  Future<Database> get database async {
    // if (_db != null) return _db;P
    _db = await open();
    return _db;
  }

  // FutureOr<Void> _onUpgrade(Database db, int oldVer, int newVer) {}

  Future open() async {
    var dbPath = join(await getDatabasesPath(), _dbPathName);
    const createQuery = '''
          'CREATE TABLE $_tablePassFolder (
            $_columnId INTEGER PRIMEY KEY AUTOINCREMENT,
            $_columnFolderName TEXT NOT NULL,
            $_columnFolderValue TEXT
          )'
        ''';

    _db = await openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) async => {
        await db.execute('''
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
    print('_init database at $dbPath');
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
    await db.close();
    return folderId;
  }

  Future deleteFolder(PassFolder folder) async {
    final db = await database;
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $_tablePassFolder ( $_columnFolderName, $_columnFolderValue ) VALUES (?, ?);',
          [folder.folderName, folder.folderSubtitle]);
      // return id1;
    });

    return null;
  }

  Future updateFolder(PassFolder folder) async {
    final db = await database;
    var folderMap = folder.toMap();
    print('update folderMap');
    print(folderMap);

    var result = await db.update(_tablePassFolder, folderMap,
        where: 'id = ?', whereArgs: [folderMap['id']]);

    return result;
  }

  Future getPassFolder(String foldername) async {
    List<Map> list = await _db.query(
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
    for (var i = 0; i < list.length; i++) {
      // print('get all passfolder ${list[i].to}');
    }

    return list;
  }
}
