import 'package:flutter/material.dart';

class ConfigProvider with ChangeNotifier {
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  changeIndex(int index) {
    if (_tabIndex != index) {
      _tabIndex = index;
      notifyListeners();
    }
  }
}
