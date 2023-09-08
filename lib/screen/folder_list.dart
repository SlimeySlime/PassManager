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
  // final folderRepo = FolderRepository();

  final searchController = TextEditingController();
  final FocusNode _searctTextFocus = FocusNode();
  var searchKeyword = '';

  late final FolderProvider _fp1;
  late List<Map> _folders = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fp1 = Provider.of<FolderProvider>(context);
  //   Future.delayed(Duration.zero, () {
  //     _getInitialFolders();
  //   });
  // }

  // void _getInitialFolders() async {
  //   folders = await fp1.getAllPassFolder();
  // }

  // var _isInit = true;
  // var _isLoading = false;
  // @override
  // void didChangeDependencies() {
  //   print('check didChangeDependencies');
  //   _isLoading = true;
  //   if (_isInit) {
  //     _fp1.getAllPassFolder().then((value) => setState(() {
  //           _isLoading = false;
  //         }));
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  void onSearchTextChange() {
    setState(() {
      searchKeyword = searchController.text;
    });
  }

  void folderIconUpdate(int iconData) {
    print('this will change iconData to $iconData');
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FolderProvider>(context);
    _fp1 = Provider.of<FolderProvider>(context);

    // var folders = fp.items;

    void dbTestInsert() async {
      // await fp.insert(PassFolder(searchKeyword, 'no value now'));
      // _folders = fp.items;
      await _fp1.insert(PassFolder(searchKeyword, 'no value now'));
      _folders = _fp1.items;
    }

    void deleteFolder(int id) async {
      // await fp.deleteFolder(id);
      // _folders = fp.items;
      await _fp1.deleteFolder(id);
      _folders = _fp1.items;
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
            _folders.isNotEmpty
                // (_isInit == false)
                ? SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemBuilder: (BuildContext ctx, int index) => FolderItem(
                        folderName: _folders[index].values.toList()[1],
                        deleting: () {
                          deleteFolder(_folders[index].values.toList()[0]);
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
                      itemCount: _folders.length,
                    ),
                  )
                : const Text('no items')
          ],
        ),
      ),
    );
  }
}
