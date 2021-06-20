import 'package:flutter/material.dart';

class HexConverter {
  static Color toColor(String hex) {
    int converting = int.parse('0xFF$hex');
    Color color = Color(converting);
    print(color.toString());
    return color;
  }
}
