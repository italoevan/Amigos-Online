import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  SettingsItem({@required this.title, this.onTap, this.icon});

  final Icon icon;
  final Function onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        leading: icon,
      ),
    );
  }
}
