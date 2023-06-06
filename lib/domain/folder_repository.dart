import 'package:passmanager/domain/passfolder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FolderRepository {
  // static final FolderRepository instance = FolderRepository._instance();

  static const String _tablePassFolder = 'PassFolder';
  static const String _columnId = 'id';
  static const String _columnFolderName = 'folder_name';
  static const String _columnFolderValue = 'folder_value';

  static const _dbPathName = 'passfolder.db';

  late Database _db;

  // FolderRepository._instance() {
  //   open();
  // }

  // FolderRepository() == instance;
  // factory FolderRepository() {
  //   return instance;
  // }

  Future<Database> get database async {
    // if (_db != null) return _db;
    _db = await open();
    return _db;
  }

  Future open() async {
    var _dbPath = join(await getDatabasesPath(), _dbPathName);
    const createQuery = '''
          'CREATE TABLE $_tablePassFolder (
            $_columnId INTEGER PRIMEY KEY AUTOINCREMENT,
            $_columnFolderName TEXT NOT NULL,
            $_columnFolderValue TEXT
          )'
        ''';
    // await deleteDatabase(_dbPath);
    _db = await openDatabase(_dbPath,
        version: 1,
        onCreate: (_db, version) async => {
              await _db.execute(
                  'CREATE TABLE PassFolder (id INTEGER PRIMARY KEY, $_columnFolderName TEXT, $_columnFolderValue TEXT )')
            });
    print('_init database at $_dbPath');
    return _db;
  }

  Future close() async {
    await _db.close();
  }

  Future<int> insert(PassFolder folder) async {
    final db = await database;
    var folderId;
    await _db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $_tablePassFolder ($_columnFolderName, $_columnFolderValue) VALUES (?, ?)',
          [folder.foldername, folder.foldervalue]);
      folderId = id1;
    });
    return folderId;
    // print(result);
    // return result;
    // return await db.insert(_tablePassFolder, passfolder.toMap(),
    //     conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future insertRawLocal(PassFolder folder) async {
    final db = await database;
  }

  Future deleteFolder(int id) async {
    final db = await database;
    var result = await db
        .delete(_tablePassFolder, where: '$_columnId = ?', whereArgs: [id]);
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
    return list;
  }
}
