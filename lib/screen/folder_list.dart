// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:passmanager/domain/passfolder.dart';
// import 'package:passmanager/domain/passfolder_repository.dart';
import 'package:passmanager/db/sqlitelocal.dart';
import 'package:passmanager/domain/passfolder_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FolderList extends StatefulWidget {
  FolderList({super.key});

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  final searchController = TextEditingController();
  var searchKeyword = '';
  // void createSampleData() async {
  //   var result = await PassFolderRepository.create(PassFolder());
  //   print(result);
  // }

  void onSearchTextChange() {
    setState(() {
      searchKeyword = searchController.text;
    });
  }

  void addFolder(String folderName) {
    print('${searchController.text} should added (text)');
  }

  void db_testing() async {
    // print('async db_testing');
    // var db_path = join(await getDatabasesPath(), 'demo.db');
    // // await deleteDatabase(db_path);
    // Database db = await openDatabase(db_path,
    //     version: 1,
    //     onCreate: ((db, version) async => {
    //           await db.execute(
    //               'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value TEXT)')
    //         }));

    // await db.transaction((txn) async {
    //   int id1 = await txn.rawInsert(
    //       'INSERT INTO Test (name, value) VALUES ("testing 1", "okdk")');
    //   print(
    //     'inserting ${id1}',
    //   );
    // });

    // List<Map> list = await db.rawQuery('SELECT * FROM Test');
    // print(list);

    var folderProvider = FolderProvider();
    var id = folderProvider.insert(PassFolder('folder test1', ''));
    print(folderProvider.getAllPassFolder());
  }

  void get_list() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchKeyword = value;
              });
            },
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Search',
            ),
          ),
        ),
        const Row(
          children: [
            Icon(Icons.search),
            Flexible(child: TextField()),
            Text('testing22'),
          ],
        ),
        TextButton(
            onPressed: () => db_testing(),
            child: Text('test search by ' + searchKeyword))
      ],
    );
  }
}
