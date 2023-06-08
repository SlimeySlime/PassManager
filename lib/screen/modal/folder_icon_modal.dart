import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FolderIconModal extends StatefulWidget {
  const FolderIconModal({super.key});

  @override
  State<FolderIconModal> createState() => _FolderIconModalState();
}

class _FolderIconModalState extends State<FolderIconModal> {
  final List<Icon> _iconDatas = [
    Icon(IconData(555, fontFamily: 'MaterialIcons')),
    Icon(IconData(5256)),
    Icon(IconData(5457)),
    Icon(Icons.abc),
    Icon(Icons.delete),
    Icon(
      IconData(984246, fontFamily: 'MaterialIcons'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '아이콘 선택',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        SizedBox(
          height: 200,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 2),
            itemBuilder: (context, index) {
              return IconButton(
                  onPressed: () {
                    final ico = _iconDatas[index].icon.toString();
                    print(ico);
                  },
                  icon: _iconDatas[index]);
            },
            itemCount: _iconDatas.length,
          ),
        ),
      ]),
    );
  }
}
