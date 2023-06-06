// import 'dart:d';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

const String passTable = 'passfolder';
const String columnId = '_id';
const String columnName = 'name';

class PassFolder {
  late int id;
  final String foldername;
  final String foldervalue;

  PassFolder(this.foldername, this.foldervalue);

  // Map<String, dynamic> toMap() {
  //   return {columnId: id, columnName: foldername};
  // }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'foldername': foldername,
      'foldervalue': foldervalue,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    return {columnId: id, columnName: foldername};
  }

  // factory PassFolder.fromJson(Map<String, dynamic> json) {
  //   return PassFolder(
  //     id: json[columnId],
  //     name: json[columnName],
  //   );
  // }
}

// class PassFolderAlt {
//   late int id;
//   final String foldername;
//   final String foldervalue;

//   PassFolderAlt(this.foldername, this.foldervalue);

//   Map<String, Object?> toMap() {
//     var map = <String, Object?>{
//       'foldername': foldername,
//       'foldervalue': foldervalue,
//     };
//     if (id != null) {
//       map[columnId] = id;
//     }
//     return map;
//   }

//   PassFolder.fromMap(Map<String, Object?> map) {
//     id = map[columnId];
//     foldername = map[columnFolderName];
//   }
// }
