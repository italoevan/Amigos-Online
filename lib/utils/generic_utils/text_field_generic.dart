import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  GenericTextField({@required this.controller, this.error, this.hasHint, this.textHint});
  final bool hasHint;
  final String error;
  final String textHint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hasHint != null ? textHint : null ,
          errorText: error != null ? error : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
