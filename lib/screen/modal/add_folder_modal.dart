import 'package:flutter/material.dart';
import 'package:passmanager/screen/pass_screen.dart';

class AddFolderModal extends StatefulWidget {
  const AddFolderModal({super.key});

  @override
  State<AddFolderModal> createState() => _AddFolderModalState();
}

class _AddFolderModalState extends State<AddFolderModal> {
  final _foldernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text('ok dialog'),
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(PassScreen.routeName);
            },
            icon: const Icon(Icons.access_time_filled_rounded))
      ]),
    );
  }
}
