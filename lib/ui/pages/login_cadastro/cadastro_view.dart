import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Container(
          margin: EdgeInsets.all(Get.width * 0.05),
          //color: Colors.red,
          
        ),
      ),
    );
  }
}
