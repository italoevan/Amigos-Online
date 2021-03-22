import 'package:flutter/material.dart';

class SignupDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: SizedBox(
        height: 8,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey[500],
          ))),
        ),
      ),
    );
  }
}
