import 'package:amigos_online/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Center(
            child: RaisedButton(onPressed: () {
              Get.toNamed(Routes.CADASTRO);
            }, child: Text('Cadastro'))),
      ),
    );
  }
}
