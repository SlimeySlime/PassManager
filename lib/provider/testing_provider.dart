import 'package:flutter/material.dart';
import 'package:passmanager/domain/passfolder.dart';

class Testing_Provider with ChangeNotifier {
  late final Map<String, PassFolder> _passfolders = {};

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
