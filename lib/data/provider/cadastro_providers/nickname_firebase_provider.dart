import 'package:amigos_online/utils/firebase_utils/endpoints/nick_name_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NickNameProvider {
  final FirebaseFirestore firestore;

  NickNameProvider({@required this.firestore});

  Future createNick({@required apelido, @required id}) async {
    print('$apelido $id');
    Map<String, dynamic> map = {"name": "$apelido"};

    await firestore
        .collection('users')
        .doc(id)
        .set({"user_id": id, "n_posts": 0});

    var response = await NickNameEndpoints()
        .post(firebaseFirestore: firestore, id: id, map: map);

    return response;
  }
}
