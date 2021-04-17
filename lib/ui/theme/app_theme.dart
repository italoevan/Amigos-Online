import 'package:flutter/material.dart';

class AppTheme {
  static var dark = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
          centerTitle: true, titleTextStyle: TextStyle(fontFamily: 'Quantum')));

  static var white = ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          centerTitle: true, titleTextStyle: TextStyle(fontFamily: 'Quantum')));
}
