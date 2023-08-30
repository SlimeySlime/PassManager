import 'package:flutter/material.dart';
import 'package:passmanager/domain/folder_provider.dart';
import 'package:passmanager/domain/folder_repository.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/pass_screen.dart';
import 'package:provider/provider.dart';

class AddFolderModal extends StatelessWidget {
  // final void Function(String itemName) addFolder;
  // const AddFolderModal({super.key, required this.addFolder});
  const AddFolderModal({super.key});

  @override
  Widget build(BuildContext context) {
    final _foldernameController = TextEditingController();
    final fp = Provider.of<FolderProvider>(context);

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
                      fp.insert(PassFolder(
                          _foldernameController.text, "no value nows.."));
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
