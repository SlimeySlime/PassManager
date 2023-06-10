import 'package:flutter/material.dart';
import 'package:passmanager/domain/folder_repository.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/pass_screen.dart';

class AddFolderModal extends StatefulWidget {
  // const AddFolderModal({super.key, required this.folderAdd});
  const AddFolderModal({super.key});

  @override
  State<AddFolderModal> createState() => _AddFolderModalState();

  // final Function folderAdd;
}

class _AddFolderModalState extends State<AddFolderModal> {
  final _foldernameController = TextEditingController();

  void _addFolder() async {
    final FolderRepository repo = FolderRepository();
    await repo.insert(PassFolder(_foldernameController.text, ''));
    print(
        'todo - this should add folder ${_foldernameController.text} and pop dialog');
    // widget.folderAdd(_foldernameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 320,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const Text(
            '폴더 이름',
            style: TextStyle(fontSize: 24.0),
          ),
          TextField(
            autofocus: true,
            controller: _foldernameController,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        // backgroundColor: Theme.of(context).buttonTheme.colorScheme.background;
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('취소', style: TextStyle(color: Colors.white)),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        // backgroundColor: Theme.of(context).buttonTheme.colorScheme.background;
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: () {
                      _addFolder();
                      // widget.folderAdd(_foldernameController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('추가하기',
                        style: TextStyle(color: Colors.white)),
                  ),
                )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
