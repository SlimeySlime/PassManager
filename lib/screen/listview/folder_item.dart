
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:passmanager/screen/pass_screen.dart';

class FolderItem extends StatelessWidget {
  // const FolderItem({super.key, required this.folder});

  // final PassFolder folder;
  const FolderItem(
      {super.key,
      required this.folderInfo,
      required this.folderId,
      required this.folderName,
      required this.deleting,
      required this.iconClick});
  final PassFolder folderInfo;
  final int folderId;
  final String folderName;
  final Function deleting;
  final Function iconClick;

  int getRadixInt(int value) {
    String hexa = '0x${value.toRadixString(16)}';
    print('$value -> getRadixInt $hexa');
    return int.parse(hexa);
  }

  @override
  Widget build(BuildContext context) {
    // Dissmisible
    print(folderInfo);
    print('this item.IconData ${folderInfo.folderIconData}');

    return Card(
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            iconClick();
          },
          child: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: FittedBox(
                child: Icon(IconData(
                    getRadixInt(folderInfo.folderIconData ?? 98456),
                    fontFamily: 'MaterialIcons')),
                // child: Icon(IconData(0xe03d, fontFamily: 'MaterialIcons')),
              ),
            ),
          ),
        ),
        title: Text(folderInfo.folderName),
        subtitle: const Text('subtitle'),
        trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              print('pressed');
              deleting();
            }),
        onTap: () {
          Navigator.pushNamed(context, PassScreen.routeName,
              arguments: {'id': folderInfo.id, 'name': folderInfo.folderName});
          // Navigator.of(context).push(folderScreenAnimation(folderId));
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
