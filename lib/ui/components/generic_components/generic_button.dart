import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  GenericButton(
      {@required this.onPressed,
      @required this.title,
      this.shadowColor,
      this.buttonColor});

  final Function onPressed;
  final String title;
  final Color shadowColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ElevatedButton.styleFrom(
          shadowColor: shadowColor != null ? shadowColor : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          primary: buttonColor != null ? buttonColor : Colors.green),
    );
  }
}
