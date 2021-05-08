import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  EmptyPage({String message}) : this.message = message;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/bad-review.png', height: 110, width: 110),
          SizedBox(
            height: 15,
          ),
          Text(
            message != null ? message : "Você não segue nenhum post ainda",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
