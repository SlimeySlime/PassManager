import 'package:flutter/material.dart';
import 'package:passmanager/animation/folderscreen_navigate.dart';
import 'package:passmanager/domain/folder_provider.dart';
import 'package:passmanager/domain/folder_repository.dart';
import 'package:passmanager/domain/iconList.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/listview/folder_item.dart';
import 'package:passmanager/screen/modal/folder_icon_modal.dart';
// import 'package:passmanager/screen/pass_screen.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';

// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:sqflite/sqflite.dart';

class FolderList extends StatefulWidget {
  static const String routeName = '/folder_list';

  FolderList({super.key});

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  final folderRepo = FolderRepository();

  final searchController = TextEditingController();
  final FocusNode _searctTextFocus = FocusNode();
  var searchKeyword = '';

  late List<Map> folders = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
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

  void addFolder(String folderName) async {
    var insertedId =
        await folderRepo.insert(PassFolder(searchKeyword, 'no value'));
    print('inserted ID : $insertedId');

    var folderList = await folderRepo.getAllPassFolder();

    setState(() {
      folders = folderList;
    });
  }

  void folderIconUpdate(int iconData) {
    print('this will change iconData to $iconData');
  }

  void dbTestInsert() async {
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
    final fp = Provider.of<FolderProvider>(context);
    var folderList = fp.items;

    void dbTestInsert() async {
      var id = fp.insert(PassFolder(searchKeyword, 'no value now'));
      // var insertedId = await folderRepo.insert(PassFolder(searchKeyword, 'no value'));
      // setState(() {
      //   folders = folderList;
      // });
    }

    void deleteFolder(int id) async {
      fp.deleteFolder(id);
    }

    return SizedBox(
      height: 1200,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Icon(Icons.search),
                  ),
                  Flexible(
                    child: TextField(
                      focusNode: _searctTextFocus,
                      autofocus: false,
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
                ],
              ),
            ),
            TextButton(
                onPressed: () => dbTestInsert(),
                child: Text('db testing insert $searchKeyword')),
            TextButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed(PassScreen.routeName);
                  Navigator.of(context).push(folderScreenAnimation());
                },
                child: const Text('to PassScreen')),
            folderList.isNotEmpty
                ? SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemBuilder: (BuildContext ctx, int index) => FolderItem(
                        folderName: folderList[index].values.toList()[1],
                        deleting: () {
                          deleteFolder(folderList[index].values.toList()[0]);
                        },
                        iconClick: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                    child: FolderIconModal(
                                        iconClick: folderIconUpdate,
                                        iconDatas: FolderIconList),
                                  ));
                        },
                      ),
                      itemCount: folders.length,
                    ),
                  )
                : const Text('no items')
          ],
        ),
      ),
    );
  }
}
