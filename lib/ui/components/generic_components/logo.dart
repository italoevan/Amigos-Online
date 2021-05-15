import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({fontSize}) : this.fontSize = fontSize;
  final fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      "AMIGOS\n  ONLINE",
      style: TextStyle(
          fontFamily: "Quantum", fontSize: fontSize != null ? fontSize : 40),
    );
  }
}
