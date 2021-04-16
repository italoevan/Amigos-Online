import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider {
  LoginProvider({@required this.auth});

  final FirebaseAuth auth;

  Future<dynamic> signIn(
      {@required String email, @required String password}) async {
    try {
      var response = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
