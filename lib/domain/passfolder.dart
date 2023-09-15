// import 'dart:d';

// static const String _columnId = 'id';
// static const String _tablePassFolder = 'PassFolder';
// static const String _columnFolderName = 'folder_name';
// static const String _columnFolderSubtitle = 'folder_subtitle';
// static const String _columnFolderIconData = 'folder_Icon_data';
// static const String _columnFolderIconColor = 'folder_Icon_color';
// static const String _columnFolderColor = 'folder_color';

const String passTable = 'passfolder';
const String columnId = 'id';
// const String columnName = 'name';

class PassFolder {
  late int? id;
  late String folderName;
  late String? folderSubtitle;
  late int? folderIconData;
  late String? folderIconColor;
  late String? folderColor;

  PassFolder(this.folderName,
      {this.id = -1,
      this.folderSubtitle = '',
      this.folderIconData = -1,
      this.folderIconColor = '',
      this.folderColor = ''});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'folder_name': folderName,
      'folder_subtitle': folderSubtitle,
      'folder_color': folderColor,
      'folder_Icon_data': folderIconData,
      'folder_Icon_color': folderIconColor,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return '$folderName - $folderIconData - $id';
  }

  factory PassFolder.fromMap(Map<dynamic, dynamic> map) {
    // return PassFolder(
    //   map['folder_name'],
    //   id: map['id'] ? map['id'] : -1,
    //   folderSubtitle: map['folder_subtitle'] ? map['folder_subtitle'] : '',
    //   folderColor: map['folder_folder_Color'] ? map['folder_folder_Color'] : '',
    //   folderIconData:
    //       map['folder_folder_IconData'] ? map['folder_folder_IconData'] : '',
    //   folderIconColor:
    //       map['folder_folder_IconColor'] ? map['folder_folder_IconColor'] : '',
    // );
    return PassFolder(
      map['folder_name'],
      id: map['id'],
      folderSubtitle: map['folder_subtitle'],
      folderColor: map['folder_color'],
      folderIconData: map['folder_Icon_data'],
      folderIconColor: map['folder_Icon_color'],
    );
  }
}
