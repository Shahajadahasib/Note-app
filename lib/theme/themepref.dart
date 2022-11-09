import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ThemePref with ChangeNotifier {
//   String status = 'theme status';

//   setTheme(bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(status, value);
//   }

//   Future<bool> getTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(status) ?? false;
//   }
// }

class ThemePrefrence with ChangeNotifier {
  String status = 'Status';
  setThemeData(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(status, value);
  }

  Future<bool> getThemeData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(status) ?? false;
  }
}
