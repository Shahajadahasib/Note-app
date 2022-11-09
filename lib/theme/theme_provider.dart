import 'dart:developer';

import 'package:demo2/theme/themepref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider with ChangeNotifier {
//   ThemePref pref = ThemePref();
//   bool _isDarkMode = false;
//   bool get isDarkMode => _isDarkMode;
//   set setDarkTheme(bool value) {
//     _isDarkMode = value;
//     pref.setTheme(value);
//     log('fsfgs');
//     notifyListeners();
//   }
// }

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










// class ThemeProvider with ChangeNotifier {
//   ThemePref themePref = ThemePref();
//   bool _setTheme = false;
//   bool get setTheme => _setTheme;

//   set changeTheme(bool data) {
//     _setTheme = data;
//     themePref.setValue(data);
//     log('gjhg');
//     notifyListeners();
//   }
  
// }

// class ThemePref with ChangeNotifier {
//   setValue(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool('Theme', value);
//     log('setvalue');
//     notifyListeners();
//   }

//   Future<bool> getValue() async {
//     final prefs = await SharedPreferences.getInstance();
//     var data = prefs.getBool('Theme') ?? false;
//     log(data.toString());
//     return data;
//   }
// }
