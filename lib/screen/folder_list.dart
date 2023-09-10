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

  void testing() {
    print(_fp.items);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    print("_FolderList build()");
    _folders = _fp.items;
    late PassFolder _focusedFolder;

    void insertFolder() async {
      await _fp
          .insert(PassFolder(searchKeyword, folderSubtitle: 'no value now'));
      _folders = await _fp.getAllPassFolder();
    }

    void deleteFolder(int id) async {
      _fp.deleteFolder(id);
      _folders = await _fp.getAllPassFolder();
    }

    void folderIconUpdate(int iconData) {
      print('this will change iconData to $iconData');
      _focusedFolder.folderIconData = iconData;
      _fp.updateFolder(_focusedFolder);
    }

    void setCurrentFolder(PassFolder folder) {
      print('current focused folder : ${folder}');
      _focusedFolder = folder;
    }

    return SizedBox(
      height: screenHeight,
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
                onPressed: () => testing(),
                child: Text('db testing $searchKeyword')),
            _fp.items.isNotEmpty
                ? SizedBox(
                    child: Container(
                      height: 500,
                      child: ListView.builder(
                        // TODO - toList to toMap needed
                        itemBuilder: (BuildContext ctx, int index) =>
                            FolderItem(
                          folderInfo: PassFolder.fromMap(_fp.items[index]),
                          folderId: _fp.items[index].values.toList()[0],
                          folderName: _fp.items[index].values.toList()[1],
                          deleting: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("항목 삭제?"),
                                  content: Text(
                                      "${_fp.items[index].values.toList()[1]} 항목을 삭제합니까? \n 하위 항목들이 모두 삭제됩니다."),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("취소"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteFolder(_fp.items[index].values
                                            .toList()[0]);
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
                            print(_fp.items[index]);
                            setCurrentFolder(
                                PassFolder.fromMap(_fp.items[index]));
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                      child: FolderIconModal(
                                          // iconClick: folderIconUpdate(PassFolder.fromMap(_fp.items[index]), 5),
                                          iconClick: folderIconUpdate,
                                          iconDatas: FolderIconList),
                                    ));
                          },
                        ),
                        itemCount: _fp.items.length,
                      ),
                    ),
                  )
                : const Text('no items'),
          ],
        ),
      ),
    );
  }
}
