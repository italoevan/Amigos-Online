import 'package:amigos_online/data/models/posts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtherComentsProvider {
  final FirebaseFirestore firestore;
  OtherComentsProvider({@required this.firestore});

  Future getOthersUsersComents({@required PostsModel model}) async {
    try {
      var response = await firestore
          .collection('users')
          .doc(model.user_id)
          .collection('posts')
          .get();
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
