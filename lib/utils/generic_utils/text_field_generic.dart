import 'package:flutter/material.dart';

class GenericTextField extends StatefulWidget {
  GenericTextField(
      {@required this.controller,
      this.error,
      this.hasHint,
      this.textHint,
      this.isPassword,
      this.maxLength
      });
  final bool hasHint;
  final String error;
  final String textHint;
  final bool isPassword;
  final int maxLength;
  bool passwordIsVisible = false;
  final TextEditingController controller;

  @override
  _GenericTextFieldState createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength:widget.maxLength ,
      obscureText: widget.isPassword != null
          ? !widget.passwordIsVisible
              ? true
              : false
          : false,
      controller: widget.controller,
      
      decoration: InputDecoration(
          suffix: widget.isPassword == true ? InkWell(
            child: Icon(Icons.remove_red_eye_sharp),
            onTap: () {
              setState(() {
                widget.passwordIsVisible = !widget.passwordIsVisible;
              });
            },
          ) : null,
          hintText: widget.hasHint != null ? widget.textHint : null,
          errorText: widget.error != null ? widget.error : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
