// import 'dart:d';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

// static const String _columnId = 'id';
// static const String _tablePassFolder = 'PassFolder';
// static const String _columnFolderName = 'folder_name';
// static const String _columnFolderSubtitle = 'folder_subtitle';
// static const String _columnFolderIconData = 'folder_Icon_data';
// static const String _columnFolderIconColor = 'folder_Icon_color';
// static const String _columnFolderColor = 'folder_color';

const String passTable = 'passfolder';
const String columnId = '_id';
const String columnName = 'name';

class PassFolder {
  late int id;
  late String folderName;
  late String folderSubtitle;
  late int folderIconData;
  late String folderIconColor;
  late String folderColor;

  PassFolder(this.folderName,
      [this.folderSubtitle = '',
      this.folderIconData = -1,
      this.folderIconColor = '',
      this.folderColor = '']);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'folder_name': folderName,
      'folder_subtitle': folderSubtitle,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // Map<String, dynamic> toJson() {
  //   return {columnId: id, columnName: foldername};
  // }

  factory PassFolder.fromMap() {
    return PassFolder('folderName');
  }
  // factory PassFolder.fromJson(Map<String, dynamic> json) {
  //   return PassFolder(
  //     id: json[columnId],
  //     name: json[columnName],
  //   );
  // }
}
