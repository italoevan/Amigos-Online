import 'package:flutter/material.dart';
import 'dart:math' as math;

class VipIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -math.pi / 4,
      child: Container(
        width: 50,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffDC1C13),
              Color(0xffEA4C46),
            ]),
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
            child: Text(
          "VIP",
          style: TextStyle(fontFamily: 'quantum'),
        )),
      ),
    );
  }
}
