import 'package:demo2/theme/themepref.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemePrefrence pref = ThemePrefrence();
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  set setDarkMode(bool value) {
    _isDarkMode = value;
    pref.setThemeData(value);
    notifyListeners();
  }
}
