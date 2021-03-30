import 'package:amigos_online/utils/firebase_utils/endpoints/nick_name_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NickNameProvider {
  final FirebaseFirestore firestore;

  NickNameProvider({@required this.firestore});

  Future createNick({@required apelido, @required id}) async {
    print('CREATENICK');
    Map<String, dynamic> map = {"apelido": "$apelido"};

    await NickNameEndpoints()
        .post(firebaseFirestore: apelido, id: id, map: map)
        .then((value) => value)
        .catchError((e) {
      return throw Exception(e);
    });
  }
}
