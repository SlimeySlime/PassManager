import 'package:flutter/material.dart';
import 'package:passmanager/screen/pass_list.dart';

class PassScreen extends StatelessWidget {
  static const String routeName = '/pass_screen';

  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Object?> folderInfo =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    print(folderInfo.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('${folderInfo['name']}'),
      ),
      body: const Center(child: PassList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => const Dialog(
              // child: AddFolderModal(),
              ),
        ),
        tooltip: 'Add Folder',
        child: const Icon(Icons.add),
      ), // T
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: FolderList(),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () => showDialog(
    //       context: context,
    //       builder: (BuildContext context) => Dialog(
    //         child: AddFolderModal(),
    //       ),
    //     ),
    //     tooltip: 'Add Folder',
    //     child: const Icon(Icons.add),
    //   ), // T
    // );
  }
}
