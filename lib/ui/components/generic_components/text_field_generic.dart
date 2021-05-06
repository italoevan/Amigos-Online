import 'package:flutter/material.dart';

class GenericTextField extends StatefulWidget {
  GenericTextField(
      {@required this.controller,
      this.error,
      this.hasHint,
      this.onChanged,
      this.textHint,
      this.isPassword,
      this.maxLength});
  final bool hasHint;
  final String error;
  final String textHint;
  final bool isPassword;
  final int maxLength;
  bool passwordIsVisible = false;
  final Function onChanged;
  final TextEditingController controller;

  @override
  _GenericTextFieldState createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword != null
          ? !widget.passwordIsVisible
              ? true
              : false
          : false,
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: widget.isPassword == true
              ? GestureDetector(
                  child: Icon(
                    widget.passwordIsVisible
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye_sharp,
                  ),
                  onTap: () {
                    setState(() {
                      widget.passwordIsVisible = !widget.passwordIsVisible;
                    });
                  },
                )
              : null,
          hintText: widget.hasHint != null ? widget.textHint : null,
          errorText: widget.error != null ? widget.error : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
