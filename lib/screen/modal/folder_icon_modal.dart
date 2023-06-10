import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passmanager/util/regex.dart';

class FolderIconModal extends StatelessWidget {
  const FolderIconModal(
      {super.key, required this.iconClick, required this.iconDatas});

  final Function iconClick;
  final List<Icon> iconDatas;

  // final List<Icon> iconDatas = [
  //   // Icon(IconData(555, fontFamily: 'MaterialIcons')),
  //   // Icon(IconData(5256)),
  //   // Icon(IconData(5457)),
  //   const Icon(Icons.abc),
  //   const Icon(IconData(984246, fontFamily: 'MaterialIcons')),
  //   const Icon(Icons.alarm),
  //   const Icon(Icons.access_time),
  //   const Icon(Icons.accessibility_new),
  //   const Icon(Icons.airplanemode_active),
  //   const Icon(Icons.attach_email),
  //   const Icon(Icons.attach_file),
  //   const Icon(Icons.audio_file),

  //   const Icon(Icons.delete),
  //   Icon(
  //     IconData(984246, fontFamily: 'MaterialIcons'),
  //   ),
  // ];

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
                    // print('icon.Hex to Decimal : ${icoHex}');
                    var icoDecimal = int.parse(icoHex.split('+')[1], radix: 16);
                    // print(icoDecimal);
                    iconClick(icoDecimal);
                    // print(int.parse(ico, radix: 16));
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
