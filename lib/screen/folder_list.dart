import 'package:flutter/material.dart';
// import 'package:passmanager/domain/passfolder.dart';
// import 'package:passmanager/domain/passfolder_repository.dart';
import 'package:passmanager/domain/folder_repository.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/listview/folder_item.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:sqflite/sqflite.dart';

class FolderList extends StatefulWidget {
  FolderList({super.key});

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  final folderRepo = FolderRepository();

  final searchController = TextEditingController();
  var searchKeyword = '';

  late List<Map> folders = [];
  late var foldersFuture;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // folders = await folderRepo.getAllPassFolder();
    foldersFuture = folderRepo.getAllPassFolder();
    _folderUpdate();
  }

  void _folderUpdate() async {
    final folderUpdated = await folderRepo.getAllPassFolder();
    setState(() {
      folders = folderUpdated;
    });
  }

  void onSearchTextChange() {
    setState(() {
      searchKeyword = searchController.text;
    });
  }

  void addFolder(String folderName) {
    print('${searchController.text} should added (text)');
  }

  void deleteFolder(int id) async {
    await folderRepo.deleteFolder(id);
    _folderUpdate();
  }

  void db_test_insert() async {
    // print('async db_test_insert');
    // var db_path = join(await getDatabasesPath(), 'demo.db');
    // // await deleteDatabase(db_path);
    // Database db = await openDatabase(db_path,
    //     version: 1,
    //     onCreate: ((db, version) async => {
    //           await db.execute(
    //               'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value TEXT)')
    //         }));

    // var folderRepo = FolderRepository();
    var insertedId =
        await folderRepo.insert(PassFolder(searchKeyword, 'no value'));
    print('inserted ID : $insertedId');

    var folderList = await folderRepo.getAllPassFolder();

    setState(() {
      folders = folderList;
    });
  }

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
            onPressed: () => db_test_insert(),
            child: Text('db testing button ' + searchKeyword)),
        folders.length > 1
            ? Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext ctx, int index) => FolderItem(
                    folderName: folders[index].values.toList()[1],
                    deleting: () {
                      print(
                          'shoud delete child item ${folders[index].values.toList()[1]}');
                      deleteFolder(folders[index].values.toList()[0]);
                    },
                  ),
                  itemCount: folders.length,
                ),
                // child: FutureBuilder(
                //   builder: (context, snapshot) {
                //     if (!snapshot.hasData) return CircularProgressIndicator();
                //     return ListView.builder(
                //         itemBuilder: ((context, index) => FolderItem(
                //             folderName: snapshot.data, deleting: deleting)));
                //   },
                //   future: foldersFuture,
                // ),
              )
            : Text('no folders')
      ],
    );
  }
}
