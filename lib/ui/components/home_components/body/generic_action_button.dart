import 'package:flutter/material.dart';

class GenericActionButton extends StatelessWidget {
  GenericActionButton({
    @required this.title,
    @required this.onTap,
    this.icon,
    this.hasIcon,
    this.primaryColor,
  });
  final bool hasIcon;
  final String title;
  final Function onTap;
  final Color primaryColor;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: hasIcon != null
          ? Row(
              children: [Text(title),SizedBox(width: 4,), icon],
            )
          : Text(title),
      style: ElevatedButton.styleFrom(
          primary: primaryColor != null ? primaryColor : Colors.green),
    );
  }
}
