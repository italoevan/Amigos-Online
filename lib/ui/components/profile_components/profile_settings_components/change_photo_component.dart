import 'package:flutter/material.dart';

class ChangePhotoItem extends StatelessWidget {
  ChangePhotoItem(
      {@required this.buttonColor, @required this.iconData, this.onTap});
  final Color buttonColor;
  final IconData iconData;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
