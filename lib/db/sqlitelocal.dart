// import 'package:flutter/material.dart';
import 'package:passmanager/domain/passfolder.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

const String tablePassFolder = 'PassFolder';
const String columnId = '_id';
const String columnFolderName = 'folder_name';
const String columnFolderValue = 'folder_value';

class PassFolder {
  late int id;
  final String foldername;
  final String foldervalue;

  PassFolder(this.foldername, this.foldervalue);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnFolderName: foldername,
      columnFolderValue: foldervalue,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // PassFolder.fromMap(Map<String, Object?> map) {
  //   id = map[columnId];
  //   foldername = map[columnFolderName];
  // }
}

class FolderProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path,
        version: 1,
        onCreate: (Database db, int version) async => {
              '''
          'CREATE TABLE ${tablePassFolder} (
            $columnId INTEGER PRIMEY KEY AUTOINCREMENT,
            $columnFolderName TEXT NOT NULL,
            $columnFolderValue TEXT
          )'
        '''
            });
  }

  Future close() async {
    await db.close();
  }

  Future insert(PassFolder passfolder) async {
    passfolder.id = await db.insert(tablePassFolder, passfolder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future getPassFolder(String foldername) async {
    List<Map> list = await db.query(
      tablePassFolder,
      columns: [columnFolderName, columnFolderValue],
      where: '$columnFolderName LIKE ?',
      whereArgs: [foldername],
    );
    return list;
  }

  Future getAllPassFolder() async {
    List<Map> list = await db.query(
      tablePassFolder,
      columns: [columnFolderName, columnFolderValue],
    );
    if (list.isNotEmpty) {
      return list;
    } else {
      return null;
    }
  }
}

// Future _opendb() async {
//   // final databasePath = await getData
//   final db = await OpenDynamicLibrary();
// }

// Future add(item) async {
//   final db = _opendb();
//   item.id = db.
// }

