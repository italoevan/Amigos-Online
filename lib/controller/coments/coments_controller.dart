import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/repository/other_comments_repository/other_comments_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComentsController extends GetxController {
  PostsModel model;
  ComentsController({@required this.repository});
  final OtherCommentsRepository repository;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController newPostController = TextEditingController();

  @override
  void onInit() {
    model = Get.arguments["posts_model"];
    super.onInit();
  }

  Future getOthersUsersComments() async {
    var response = await firestore
        .collection('all_posts')
        .doc(model.uid)
        .collection('coments')
        .get();
  }

  Future newComments() {}

  verification() {
    if (newPostController.text.isEmpty ||
        newPostController.text == null) {
      Get.snackbar("Atenção", "O texto não pode estar vazio");
    }
  }
}
