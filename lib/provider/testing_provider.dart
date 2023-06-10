import 'package:flutter/material.dart';
import 'package:passmanager/domain/passfolder.dart';

class Testing_Provider with ChangeNotifier {
  late Map<String, PassFolder> _passfolders = Map();

  Map<String, PassFolder> get passfolders {
    return _passfolders;
  }

  void addFolder(
    String title,
  ) {
    if (_passfolders.containsKey(title)) {
      _passfolders.update(title, (value) => PassFolder(title));
    } else {
      _passfolders.putIfAbsent(title, () => PassFolder(title));
    }
    notifyListeners();
  }
}
