import 'package:flutter/material.dart';

class NewPostButton extends StatelessWidget {
  NewPostButton({@required this.onTap});

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [BoxShadow(blurRadius: 2, color: Colors.white)],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
