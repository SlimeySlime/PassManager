import 'package:flutter/material.dart';
import 'package:passmanager/util/regex.dart';

class FolderIconModal extends StatelessWidget {
  const FolderIconModal(
      {super.key, required this.iconClick, required this.iconDatas});

  final Function(int iconData) iconClick;
  final List<Icon> iconDatas;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '아이콘 선택',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        SizedBox(
          height: 200,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 2),
            itemBuilder: (context, index) {
              return IconButton(
                  onPressed: () {
                    final ico = iconDatas[index].icon.toString();
                    final icoHex = getFromBracket(ico);
                    var icoDecimal = int.parse(icoHex.split('+')[1], radix: 16);
                    iconClick(icoDecimal);
                    Navigator.of(context).pop();
                  },
                  icon: iconDatas[index]);
            },
            itemCount: iconDatas.length,
          ),
        ),
      ]),
    );
  }
}
