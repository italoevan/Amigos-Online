import 'package:amigos_online/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amigos Online"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: (){
            auth.signOut();
            Get.offAllNamed(Routes.CADASTRO);
          })
        ],
      ),
    );
  }
}