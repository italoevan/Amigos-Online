import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/social_network_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/ui/components/profile_components/card_social_network.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileController extends GetxController {
  Rx<UserModel> model = Rx<UserModel>();

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
    model.value = Get.arguments["userModel"];
    hasNameLoaded.value = await getUserName();
    hasPostCountLoaded.value = await getPostsCount();
    hasPostsLoaded.value = await getUserPosts();
    DartNotificationCenter.subscribe(
        channel: 'profilePosts',
        observer: this,
        onNotification: (v) async {
          onRefresh();
        });
    DartNotificationCenter.subscribe(
        channel: 'profileBackgroundColor',
        observer: this,
        onNotification: (hex) {
          model.value.hexColor = hex;
          model.refresh();
        });
    getUserName();
    super.onInit();
  }

  refreshColor(String hex) {
    model.value.hexColor = hex;
  }

  onRefresh() async {
    hasPostsLoaded.value = false;
    hasPostsLoaded.value = await getUserPosts();
    refreshController.refreshCompleted();
    return;
  }

  Future<bool> getUserName() async {
    try {
      var response =
          await firestore.collection('users').doc(model.value.user_id).get();
      UserModel userModel = UserModel.fromJson(response.data());
      userName.value = userModel.name;
      return true;
    } catch (e) {
      Get.snackbar("Aten????o", "Erro");

      return false;
    }
  }

  Future<bool> getPostsCount() async {
    try {
      var response =
          await firestore.collection('users').doc(model.value.user_id).get();
      UserModel userModel = UserModel.fromJson(response.data());
      userPostsCount.value = userModel.n_posts;
      return true;
    } catch (e) {
      Get.snackbar("Aten????o", "Erro");
      return false;
    }
  }

  Future changeUserName(String value) async {
    try {
      var response = await firestore
          .collection('users')
          .doc(model.value.user_id)
          .update({"name": value});
      getUserName();
      return response;
    } catch (e) {
      Get.snackbar("Aten????o", "Erro");
    }
  }

  openSnackOnError() {
    Get.snackbar("Aten????o", "Erro ao trocar");
  }

  Future<bool> getUserPosts() async {
    try {
      var response = await firestore
          .collection('users')
          .doc(model.value.user_id)
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
        .doc(model.value.user_id)
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

  openUrlSocialNetwork(
      {@required String socialNetork, @required String url}) async {
    switch (socialNetork) {
      case 'whatsapp':
        var whatsappNumber = 'whatsapp://send?phone=$url';
        await canLaunch(whatsappNumber)
            ? launch(whatsappNumber)
            : throw 'N??o foi possivel abrir';

        break;

      case 'instagram':
        await canLaunch(url) ? launch(url) : throw 'N??o foi possivel abrir';
        break;

      case 'twitter':
        await canLaunch(url) ? launch(url) : throw 'N??o foi possivel abrir';
        break;
    }
  }
}
