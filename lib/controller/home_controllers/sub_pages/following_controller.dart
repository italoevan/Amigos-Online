import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/utils/firebase_utils/get_atual_user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var postsHasLoaded = false.obs;

  var isLoading = false.obs;

  List<PostsModel> listPosts = [];

  RefreshController refreshController = RefreshController();

  @override
  void onInit() async {
    postsHasLoaded.value = false;
    postsHasLoaded.value = await getFollowingList();

    DartNotificationCenter.subscribe(
      channel: 'examples',
      observer: this,
      onNotification: (o) async => onRefresh(),
    );
    super.onInit();
  }

Future<UserModel> getOtherUserInformation(PostsModel model) async {
    isLoading.value = true;
    try {
      var response =
          await firestore.collection('users').doc(model.user_id).get();

      UserModel otherUserModel = UserModel.fromJson(response.data());
      isLoading.value = false;
      return otherUserModel;
    } catch (e) {
      isLoading.value = false;
      return null;
    }
  }

  Future<bool> getFollowingList() async {
    String atualUser = GetAtualUserId().getUserId();
    try {
      var response = await firestore
          .collection('users')
          .doc(atualUser)
          .collection('following')
          .orderBy('uid', descending: true)
          .get();

      if (response.docs.isEmpty) {
        return null;
      }
      List<String> listFollowing = [];
      response.docs.forEach((element) {
        listFollowing.add(element.data()['uid']);
      });
      listPosts = await getPosts(listFollowing);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<PostsModel>> getPosts(List<String> list) async {
    List<PostsModel> _model = [];

    for (int i = 0; i < list.length; i++) {
      var response = await firestore
          .collection('all_posts')
          .where('uid', isEqualTo: list[i])
          .get();
      response.docs.forEach((element) {
        _model.add(PostsModel.fromJson(element.data()));
      });
    }

    return _model;
  }

  onRefresh() async {
    postsHasLoaded.value = false;
    postsHasLoaded.value = await getFollowingList();
    return;
  }
}
