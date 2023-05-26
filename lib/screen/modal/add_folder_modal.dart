import 'package:flutter/material.dart';

class AddFolderModal extends StatefulWidget {
  const AddFolderModal({super.key});

  @override
  State<AddFolderModal> createState() => _AddFolderModalState();
}

class _AddFolderModalState extends State<AddFolderModal> {
  final _foldernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: _foldernameController,
            decoration: const InputDecoration(labelText: '항목 이름'),
          ),
          // TextField(
          //   controller: null,
          //   decoration: const InputDecoration(labelText: '아이콘 /TODO'),
          // ),
        ],
      ),
    );
  }
}
