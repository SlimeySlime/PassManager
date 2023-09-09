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
    _folders = _fp.items;

    void insertFolder() async {
      await _fp.insert(PassFolder(searchKeyword, 'no value now'));
      _folders = await _fp.getAllPassFolder();
    }

    void deleteFolder(int id) async {
      _fp.deleteFolder(id);
      _folders = await _fp.getAllPassFolder();
    }

    // AlertDialog deleteConfirm = AlertDialog(
    //   title: const Text("정말 삭제합니까?"),
    //   content: Text("really? "),
    //   actions: [
    //     const ElevatedButton(
    //       onPressed: null,
    //       child: Text("취소"),
    //     ),
    //     ElevatedButton(
    //       onPressed: deleteFolder(3),
    //       child: const Text("삭제하기"),
    //     )
    //   ],
    // );

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
            _fp.items.isNotEmpty
                ? SizedBox(
                    height: 600,
                    child: ListView.builder(
                      // TODO - toList to toMap needed
                      itemBuilder: (BuildContext ctx, int index) => FolderItem(
                        folderId: _fp.items[index].values.toList()[0],
                        folderName: _fp.items[index].values.toList()[1],
                        deleting: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("정말 삭제합니까?"),
                                content: const Text("삭제된 정보는 복구가 불가능합니다."),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("취소"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteFolder(
                                          _fp.items[index].values.toList()[0]);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("삭제하기"),
                                  )
                                ],
                              );
                            },
                          );
                          // deleteFolder(_fp.items[index].values.toList()[0]);
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
                      itemCount: _fp.items.length,
                    ),
                  )
                : const Text('no items'),
          ],
        ),
      ),
    );
  }
}
