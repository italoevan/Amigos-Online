import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class CadastroProvider {
  final FirebaseAuth auth;
  CadastroProvider({@required this.auth});

  Future cadastrar(String email, String senha) async {
    var response = await auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      return value;
    }).catchError((e) {
      return e;
    });
  }
}
