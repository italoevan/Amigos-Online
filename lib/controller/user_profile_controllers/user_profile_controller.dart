import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserProfileController extends GetxController {
  final UserModel model =
      Get.arguments["userModel"]; //Use-se aso seja o proprio perfil
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController changeNameController = TextEditingController();
  var errorText = "Teste".obs;

  var userName = "Usuario".obs;
  var userPostsCount = 0.obs;

  var hasNameLoaded = false.obs;
  var hasPostCountLoaded = false.obs;
  var hasPostsLoaded = false.obs;

  List<PostsModel> listPosts;

  @override
  void onInit() async {
    hasNameLoaded.value = await getUserName();
    hasPostCountLoaded.value = await getPostsCount();
    hasPostsLoaded.value = await getUserPosts();

    getUserName();
    super.onInit();
  }

  Future<bool> getUserName() async {
    try {
      var response =
          await firestore.collection('users').doc(model.user_id).get();
      UserModel userModel = UserModel.fromJson(response.data());
      userName.value = userModel.name;
      return true;
    } catch (e) {
      Get.snackbar("Atenção", "Erro");

      return false;
    }
  }

  Future<bool> getPostsCount() async {
    try {
      var response =
          await firestore.collection('users').doc(model.user_id).get();
      UserModel userModel = UserModel.fromJson(response.data());
      userPostsCount.value = userModel.n_posts;
      return true;
    } catch (e) {
      Get.snackbar("Atenção", "Erro");
      return false;
    }
  }

  Future changeUserName(String value) async {
    try {
      var response = await firestore
          .collection('users')
          .doc(model.user_id)
          .update({"name": value});
      getUserName();
      return response;
    } catch (e) {
      Get.snackbar("Atenção", "Erro");
    }
  }

  openDialogToChangeName() {
    showDialog(
      context: Get.context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Trocar Apelido"),
              content: Container(
                child: TextField(
                  controller: changeNameController,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                FlatButton(
                  onPressed: () async {
                    if (changeNameController.text.length < 5) {
                      openSnackOnError();
                    } else if (changeNameController.text.length > 10) {
                      openSnackOnError();
                    } else {
                      //all ok
                      await changeUserName(changeNameController.text);
                      model.name = changeNameController.text;
                      Get.back();
                    }
                  },
                  child: Text("Trocar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  openSnackOnError() {
    Get.snackbar("Atenção", "Erro ao trocar");
  }

  Future<bool> getUserPosts() async {
    try {
      var response = await firestore
          .collection('users')
          .doc(model.user_id).
          collection('posts')
          .orderBy('date', descending: true)
          .get();

      List<PostsModel> postList = [];

      response.docs.forEach((element) {
        postList.add(PostsModel.fromJson(element.data()));
      });

      listPosts = postList;

      return true;
    } catch (e) {
      return false;
    }
  }
}