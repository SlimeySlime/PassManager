import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passmanager/screen/pass_screen.dart';

class PassItem extends StatelessWidget {
  // const PassItem({super.key, required this.folder});

  // final PassFolder folder;
  const PassItem(
      {super.key,
      required this.folderId,
      required this.folderName,
      required this.deleting,
      required this.iconClick});
  final int folderId;
  final String folderName;
  final Function deleting;
  final Function iconClick;

  @override
  Widget build(BuildContext context) {
    // Dissmisible
    return Card(
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            iconClick();
          },
          child: const CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(0.0),
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
              deleting();
            }),
        onTap: () {
          Navigator.pushNamed(context, PassScreen.routeName,
              arguments: {'id': folderId, 'name': folderName});
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
