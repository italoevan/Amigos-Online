import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/social_network_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/ui/components/profile_components/card_social_network.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  RefreshController refreshController = RefreshController();
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

  openSnackOnError() {
    Get.snackbar("Atenção", "Erro ao trocar");
  }

  Future<bool> getUserPosts() async {
    try {
      var response = await firestore
          .collection('users')
          .doc(model.user_id)
          .collection('posts')
          .orderBy('uid', descending: true)
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

  Future<dynamic> getSocialNetwork() async {
    SocialNetworkModel _socialNetworkModel;
    var response = await firestore
        .collection('users')
        .doc(model.user_id)
        .collection('social_network')
        .doc('social_network')
        .get();

    if (response.data() == null) {
      print("Caiu no null");
      return null;
    } else {
      _socialNetworkModel = SocialNetworkModel.fromJson(response.data());
    }

    return _socialNetworkModel;
  }

  openCardSocialNetwork(UserProfileController profileController) async {
    await Get.dialog(
        CardSocialNetwork(await getSocialNetwork(), profileController));
  }
}
