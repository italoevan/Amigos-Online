import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostButton extends StatefulWidget {
  NewPostButton({@required this.onTap, @required this.controller, });

  final HomeController controller;
  final Function onTap;
  final bool hasIcon = false;
 
  @override
  _NewPostButtonState createState() => _NewPostButtonState();
}

class _NewPostButtonState extends State<NewPostButton> {




  @override
  Widget build(BuildContext context) {
    
    return Obx(() => GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.green,
              boxShadow: [BoxShadow(blurRadius: 2, color: Colors.white)],
              borderRadius: BorderRadius.circular(100),
            ),
            child: widget.controller.atualPage.value == 1 
                ? Icon(
                    Icons.add,
                    color: Colors.white,
                  )
                : Icon(Icons.home),
          ),
        ));
  }
}
