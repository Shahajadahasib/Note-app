import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarktheme, BuildContext context) {
    return ThemeData(
      // inputDecorationTheme: InputDecorationTheme(
      //     hintStyle: TextStyle(
      //         color: isDarktheme
      //             ? const Color(0xFFF2FDFD)
      //             : const Color(0xFF00001a))),
      // textTheme: TextTheme(
      //   bodyText2: TextStyle(
      //     color: isDarktheme ? Colors.green : Colors.red,
      //   ),
      //   // bodyText1: TextStyle(
      //   //   color: Colors.red,
      //   // ),
      // ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            color: isDarktheme
                ? const Color(0xFFF2FDFD)
                : const Color(0xFF00001a)),
        iconTheme: IconThemeData(
            color: isDarktheme ? Color(0xFFF2FDFD) : Color(0xFF00001a)),
        actionsIconTheme: IconThemeData(
            color: isDarktheme ? Color(0xFFF2FDFD) : Color(0xFF00001a)),
        color: isDarktheme ? const Color(0xFF00001a) : const Color(0xFFffffff),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDarktheme
            ? Color.fromARGB(255, 45, 45, 106)
            : Color.fromARGB(255, 190, 176, 176),
      ),
      scaffoldBackgroundColor:
          isDarktheme ? const Color(0xFF00001a) : const Color(0xFFffffff),
      primaryColor: Colors.blue,
      colorScheme: ThemeData().colorScheme.copyWith(
          secondary: isDarktheme
              ? const Color(
                  0xFF1a1f3c,
                )
              : const Color(
                  0xFFF2FDFD,
                ),
          brightness: isDarktheme ? Brightness.dark : Brightness.light),
      cardColor:
          isDarktheme ? const Color(0xFF0a0d2c) : const Color(0xFFF2FDFD),
      canvasColor: isDarktheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarktheme
                ? const ColorScheme.dark()
                : const ColorScheme.light(),
          ),
    );
  }
}
