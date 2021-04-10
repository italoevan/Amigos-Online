import 'package:flutter/material.dart';

class NavigationBarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      
     decoration:BoxDecoration(
       boxShadow: [],
        color: Colors.transparent,
        borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
     )
    );
  }
}