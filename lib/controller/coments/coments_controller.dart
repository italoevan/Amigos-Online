import 'package:amigos_online/data/models/coments_posts_model.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/data/repository/other_comments_repository/other_comments_repository.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComentsController extends GetxController {
  PostsModel model;
  ComentsController({@required this.repository});
  final OtherCommentsRepository repository;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController newPostController = TextEditingController();
  UserProviderController userProviderController =
      Get.find<UserProviderController>();

  UserModel userModel;
  var isLoading = false.obs;

  @override
  void onInit() {
    userModel = userProviderController.userModel;

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

  Future newComments() async {
    if (verification()) {
      var date = Timestamp.now();

      ComentsPostsModel comentModel = ComentsPostsModel();
      comentModel.user_id = userModel.user_id;
      comentModel.user_image = userModel.user_image;
      comentModel.user_name = userModel.name;
      comentModel.content = newPostController.text;
      comentModel.date = date.toString();

      var modelJson = comentModel.toJson();

      //post in user profile

      await firestore
          .collection('users')
          .doc(model.user_id)
          .collection('posts')
          .doc(model.uid)
          .collection('coments')
          .doc(date.toString())
          .set(modelJson);

      //post in all_posts

      await firestore
          .collection('all_posts')
          .doc(model.uid)
          .collection('coments')
          .doc(date.toString())
          .set(modelJson)
          .then((value) {
        Get.snackbar("Oba!", "Sucesso ao comentar");
      });

      print(modelJson);
    } else {
      verification();
    }
  }

  bool verification() {
    if (newPostController.text.isEmpty || newPostController.text == null) {
      Get.snackbar("Atenção", "O texto não pode estar vazio");
      return false;
    } else if (newPostController.text.length > 75) {
      Get.snackbar("Atenção", "Máximo de 75 caracteres");
      return false;
    } else {
      return true;
    }
  }
}
