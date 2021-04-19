import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/utils/firebase_utils/get_atual_user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FollowingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var postsHasLoaded = false.obs;

  var isLoading = false.obs;

  List<PostsModel> listPosts = [];

  void onReady() async {
    postsHasLoaded.value = await getFollowingPosts();
    super.onInit();

    super.onReady();
  }

  Future<bool> getFollowingPosts() async {
    String atualUser = GetAtualUserId().getUserId();
    try {
      var response = await firestore
          .collection('users')
          .doc(atualUser)
          .collection('following')
          .orderBy('uid')
          .get();
      print(response.docs.isEmpty);

      if (response.docs.isEmpty) {
        return null;
      }

      List<PostsModel> list = <PostsModel>[];

      response.docs.forEach((element) {
        list.add(PostsModel.fromJson(element.data()));
      });

      listPosts = list;
      return true;
    } catch (e) {
      return false;
    }
  }
}
