import 'dart:async';

import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/data/models/coments_posts_model.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/data/repository/other_comments_repository/other_comments_repository.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/utils/firebase_utils/get_atual_user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

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
  String mainImage;
  var isLoading = false.obs;
  HomeController homeController;
  var otherComentshasLoaded = false.obs;
  final scrollController = ScrollController();
  List<ComentsPostsModel> list = [];

  @override
  void onInit() async {
    model = Get.arguments["posts_model"];
    mainImage = await getMainUserImage();
    otherComentshasLoaded.value = await getOthersUsersComments();
    userModel = userProviderController.userModel;

    super.onInit();
  }

  Future<String> getOtherUsersImage(ComentsPostsModel model) async {
    var response = await firestore.collection('users').doc(model.user_id).get();
    String value = response.data()['user_image'];
    return value;
  }

  Future<String> getMainUserImage() async {
    var response = await firestore.collection('users').doc(model.user_id).get();
    String value = response.data()['user_image'];
    mainImage = value;
    return value;
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
                  .jumpTo(scrollController.position.maxScrollExtent + 90));
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
          if (model.user_id != GetAtualUserId().getUserId()) {
            print(model.user_id + " E ${GetAtualUserId().getUserId()}");
            print('not my post');
          } else {
            newPostController.text = "";
            Get.snackbar("Oba!", "Sucesso ao comentar");
          }
        });

        //Follow the post

        if (model.user_id != GetAtualUserId().getUserId()) {
          await firestore
              .collection('users')
              .doc(GetAtualUserId().getUserId())
              .collection('following')
              .doc(model.uid)
              .set({'uid': model.uid}).then((value) {
            newPostController.text = "";
            Get.snackbar("Oba!", "Sucesso ao comentar");
            DartNotificationCenter.post(channel: 'examples');
          });
        }
        FocusScope.of(context).unfocus();
        isLoading.value = false;
        otherComentshasLoaded.value = false;
        otherComentshasLoaded.value = await getOthersUsersComments();
      } catch (e) {
        Get.snackbar("Aten????o", "Erro ao fazer o coment??rio :(");
      }
    }
  }

  bool verification() {
    if (newPostController.text.isEmpty || newPostController.text == null) {
      Get.snackbar("Aten????o", "O texto n??o pode estar vazio");
      return false;
    } else if (newPostController.text.length > 75) {
      Get.snackbar("Aten????o", "M??ximo de 75 caracteres");
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
