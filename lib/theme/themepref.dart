import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefrence with ChangeNotifier {
  String status = 'Status';
  setThemeData(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(status, value);
  }

  Future<bool> getThemeData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMood = brightness == Brightness.dark;
    return pref.getBool(status) ?? isDarkMood;
  }
}
