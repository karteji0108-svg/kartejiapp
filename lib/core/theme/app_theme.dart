import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData normal = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  static final ThemeData ramadhan = ThemeData(
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: const Color(0xFFF0FFF0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      iconTheme: IconThemeData(color: Colors.yellow),
    ),
  );

  static final ThemeData independence = ThemeData(
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: const Color(0xFFFFF0F0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  static ThemeData getTheme(String themeName) {
    switch (themeName) {
      case 'ramadhan':
        return ramadhan;
      case 'independence_day':
        return independence;
      default:
        return normal;
    }
  }
}
