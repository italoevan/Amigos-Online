import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
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
            "Você não segue nenhum post ainda",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
