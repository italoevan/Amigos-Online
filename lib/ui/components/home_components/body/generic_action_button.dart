import 'package:flutter/material.dart';

class GenericActionButton extends StatelessWidget {
  GenericActionButton({
    @required this.title,
    @required this.onTap,
    this.primaryColor,
  });

  final String title;
  final Function onTap;
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
      style: ElevatedButton.styleFrom(
          primary: primaryColor != null ? primaryColor : Colors.green),
    );
  }
}
