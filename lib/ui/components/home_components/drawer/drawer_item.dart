import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({@required this.title, this.onTap, this.icon});
  
  final String title;
  final Function onTap;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTap,
    );
  }
}