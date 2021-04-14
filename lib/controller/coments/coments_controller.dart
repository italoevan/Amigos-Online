import 'dart:async';

import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/data/models/coments_posts_model.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/data/repository/other_comments_repository/other_comments_repository.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
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
  HomeController homeController;
  var otherComentshasLoaded = false.obs;
  final scrollController = ScrollController();
  List<ComentsPostsModel> list = [];

  @override
  void onInit() async {
    model = Get.arguments["posts_model"];
    otherComentshasLoaded.value = await getOthersUsersComments();
    userModel = userProviderController.userModel;

    super.onInit();
  }

  Future<bool> getOthersUsersComments() async {
    try {
      var response = await firestore
          .collection('all_posts')
          .doc(model.uid)
          .collection('coments')
          .orderBy('uid', descending: false)
          .get();

      List<ComentsPostsModel> postList = [];
      response.docs.forEach((element) {
        postList.add(ComentsPostsModel.fromJson(element.data()));
      });
      list = postList;
      jumpToEndOfList();
      return true;
    } catch (e) {
      return false;
    }
  }

  void jumpToEndOfList() async {
    Timer(Duration(milliseconds: 400), () {
      if (otherComentshasLoaded.value == true) {
        if (list.length == 0) {
          print("Empty");
        } else {
          Timer(
              Duration(milliseconds: 400),
              () => scrollController
                  .jumpTo(scrollController.position.maxScrollExtent + 50));
        }
      }
    });
  }

  Future newComments(BuildContext context) async {
    if (verification()) {
      var uid = Timestamp.now();
      var date = DateTime.now();
      ComentsPostsModel comentModel = ComentsPostsModel();
      comentModel.user_id = userModel.user_id;
      comentModel.user_image = userModel.user_image;
      comentModel.user_name = userModel.name;
      comentModel.content = newPostController.text;
      comentModel.date = date.toString();

      var modelJson = comentModel.toJson();

      //post in user profile

      try {
        isLoading.value = true;
        await firestore
            .collection('users')
            .doc(model.user_id)
            .collection('posts')
            .doc(model.uid)
            .collection('coments')
            .doc(uid.toString())
            .set(modelJson);

        //post in all_posts

        await firestore
            .collection('all_posts')
            .doc(model.uid)
            .collection('coments')
            .doc(uid.toString())
            .set(modelJson)
            .then((value) {
          newPostController.text = "";
          Get.snackbar("Oba!", "Sucesso ao comentar");
        });
        FocusScope.of(context).unfocus();
        isLoading.value = false;
        otherComentshasLoaded.value = false;
        otherComentshasLoaded.value = await getOthersUsersComments();
      } catch (e) {
        Get.snackbar("Atenção", "Erro ao fazer o comentário :(");
      }
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

  Future getUserInformationToOpenProfile(
      ComentsPostsModel comentsPostsModel) async {
    isLoading.value = true;
    UserModel _userModel = UserModel();

    var response = await firestore
        .collection('users')
        .doc(comentsPostsModel.user_id)
        .get();
    _userModel = UserModel.fromJson(response.data());

    isLoading.value = false;
    Get.toNamed(
      Routes.USERPROFILE,
      arguments: {"isOwnProfile": false, "userModel": _userModel},
    );
  }
}
