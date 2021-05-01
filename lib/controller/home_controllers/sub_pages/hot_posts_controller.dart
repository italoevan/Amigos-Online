import 'package:amigos_online/data/models/posts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HotPostsController extends GetxController {
  var postsHasLoaded = false.obs;
  List<PostsModel> listPostsModel;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    postsHasLoaded.value = await getHotPosts();
    super.onInit();
  }

  Future<bool> getHotPosts() async {
    try {
      List<PostsModel> _listPostModel = [];
      var response = await firebaseFirestore
          .collection('all_posts')
          .orderBy('uid', descending: true)
          .get();

      response.docs.forEach((element) {
        _listPostModel.add(PostsModel.fromJson(element.data()));
      });

      _listPostModel.forEach((element) {});

      listPostsModel = _listPostModel;
      return true;
    } catch (e) {
      return false;
    }
  }
}
