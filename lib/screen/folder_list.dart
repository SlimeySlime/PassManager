import 'package:flutter/material.dart';
import 'package:passmanager/animation/folderscreen_navigate.dart';
import 'package:passmanager/domain/folder_provider.dart';
import 'package:passmanager/domain/iconList.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/listview/folder_item.dart';
import 'package:passmanager/screen/modal/folder_icon_modal.dart';
import 'package:provider/provider.dart';

class FolderList extends StatefulWidget {
  static const String routeName = '/folder_list';

  FolderList({super.key});

  // late final FolderProvider _fpMain = Provider.of<FolderProvider>(context);

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  // final folderRepo = FolderRepository();

  final searchController = TextEditingController();
  final FocusNode _searctTextFocus = FocusNode();
  var searchKeyword = '';

  late final FolderProvider _fp = Provider.of<FolderProvider>(context);
  late List<Map> _folders = [];
  late Future _foldersFuture = _fp.getAllPassFolder();

  // @override
  // void initState() {
  //   super.initState();
  //   print("FolderListState initState()");
  //   _fp1 = Provider.of<FolderProvider>(context);
  //   Future.delayed(Duration.zero, () {
  //     _getInitialFolders();
  //     print("delayed initState by getAllPassFolder");
  //   });
  // }

  // void _getInitialFolders() async {
  //   _folders = await _fp1.getAllPassFolder();
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
    // final fp = Provider.of<FolderProvider>(context, listen: false);
    print("_FolderList build()");
    print("fp.items.length ${_fp.items.length}");

    var _folders = _fp.items;

    void insertFolderFuture() {
      _fp
          .insert(PassFolder(searchKeyword, 'no value now'))
          .then((value) => _foldersFuture = _fp.getAllPassFolder());
    }

    void insertFolder() async {
      await _fp.insert(PassFolder(searchKeyword, 'no value now'));
      _folders = await _fp.getAllPassFolder();
    }

    void deleteFolderFuture(int id) {
      _fp
          .deleteFolder(id)
          .then((value) => _foldersFuture = _fp.getAllPassFolder());
    }

    void deleteFolder(int id) async {
      _fp.deleteFolder(id);
      _folders = await _fp.getAllPassFolder();
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
                onPressed: () => insertFolder(),
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
                : const Text('no items'),

            // FutureBuilder(
            //   future: _foldersFuture,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return SizedBox(
            //         height: 600,
            //         child: ListView.builder(
            //           itemBuilder: (BuildContext ctx, int index) => FolderItem(
            //             folderName: snapshot.data![index].values.toList()[1],
            //             deleting: () {
            //               deleteFolder(
            //                   snapshot.data![index].values.toList()[0]);
            //             },
            //             iconClick: () {
            //               showDialog(
            //                   context: context,
            //                   builder: (BuildContext context) => Dialog(
            //                         child: FolderIconModal(
            //                             iconClick: folderIconUpdate,
            //                             iconDatas: FolderIconList),
            //                       ));
            //             },
            //           ),
            //           itemCount: snapshot.data!.length,
            //         ),
            //       );
            //     } else {
            //       return const CircularProgressIndicator();
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
