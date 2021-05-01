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
          .limit(50)
          .get();

      List<String> uidList = [];
      getUidOfLast50(response, uidList);
      await filter(uidList, _listPostModel);

      listPostsModel = _listPostModel;
      return true;
    } catch (e) {
      return false;
    }
  }

  getUidOfLast50(QuerySnapshot response, List<String> uidList) {
    response.docs.forEach((element) {
      uidList.add(PostsModel.fromJson(element.data()).uid);
    });
  }

  Future<void> filter(
      List<String> uidList, List<PostsModel> _listPostModel) async {
    uidList.forEach((element) async {
      var _response = await firebaseFirestore
          .collection('all_posts')
          .doc(element)
          .collection('coments')
          .get();
      if (_response.size > 5) {
        var _filteredResponse =
            await firebaseFirestore.collection('all_posts').doc(element).get();
        _listPostModel.add(PostsModel.fromJson(_filteredResponse.data()));
      }
    });
  }
}
