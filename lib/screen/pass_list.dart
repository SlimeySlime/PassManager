import 'package:flutter/material.dart';
import 'package:passmanager/screen/listview/pass_item.dart';

class PassList extends StatefulWidget {
  const PassList({super.key});

  @override
  State<PassList> createState() => _PassListState();
}

class _PassListState extends State<PassList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1200,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.abc), iconSize: 32.0),
                Text(
                  'ok',
                  style: TextStyle(fontSize: 48.0),
                )
              ],
            ),
            PassItem(
                folderId: 1,
                folderName: 'test',
                deleting: () {},
                iconClick: () {})
          ],
        ),
      ),
    );
  }
}
