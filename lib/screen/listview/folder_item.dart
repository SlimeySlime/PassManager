import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/pass_screen.dart';

class FolderItem extends StatelessWidget {
  // const FolderItem({super.key, required this.folder});

  // final PassFolder folder;
  const FolderItem(
      {super.key,
      required this.folderName,
      required this.deleting,
      required this.iconClick});
  final String folderName;
  final Function deleting;
  final Function iconClick;

  @override
  Widget build(BuildContext context) {
    // Dissmisible
    return Card(
      child: ListTile(
        leading: GestureDetector(
          onLongPress: () {
            iconClick();
          },
          onTap: () {
            print('icon open');
            iconClick();
          },
          child: const CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: FittedBox(
                child: Icon(Icons.abc),
              ),
            ),
          ),
        ),
        title: Text(folderName),
        subtitle: const Text('subtitle'),
        trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              print('pressed');
              print('ok');
              deleting();
            }),
        onTap: () {
          Navigator.of(context).pushNamed(PassScreen.routeName);
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('folderName', folderName));
  }
}
