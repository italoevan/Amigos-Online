import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorGrid extends StatelessWidget {
  final Function(String) onTap;

  ColorGrid({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.5,
      width: Get.width * 0.8,
      color: Colors.red,
    );
  }
}
