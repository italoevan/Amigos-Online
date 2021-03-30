import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CadastroProvider {
  final FirebaseAuth auth;
  CadastroProvider({@required this.auth});

  Future cadastrar(String email, String senha) async {
    try {
      var response = await auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      return response;
    } catch (e) {
      Get.snackbar('Atenção', 'Algo deu errado : $e');
      return e;
    }
  }
}
