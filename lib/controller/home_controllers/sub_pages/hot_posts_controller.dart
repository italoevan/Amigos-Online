import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotPostsController extends GetxController {
  var postsHasLoaded = false.obs;
  var listPostsModel = RxList<PostsModel>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RefreshController refreshController = RefreshController();
  var isLoading = false.obs;
  @override
  void onInit() async {
    postsHasLoaded.value = await getHotPosts();
    super.onInit();
  }

  refresh() async {
    postsHasLoaded.value = false;
    postsHasLoaded.value = await getHotPosts();

    return;
  }

  Future<bool> getHotPosts() async {
    isLoading.value = true;
    try {
      var response = await firebaseFirestore
          .collection('all_posts')
          .orderBy('uid', descending: true)
          .limit(50)
          .get();

      List<String> uidList = [];
      getUidOfLast50(response, uidList);

      listPostsModel = await filter(uidList);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  getUidOfLast50(QuerySnapshot response, List<String> uidList) {
    response.docs.forEach((element) {
      uidList.add(PostsModel.fromJson(element.data()).uid);
    });
  }

  Future<RxList<PostsModel>> filter(List<String> uidList) async {
    RxList<PostsModel> _list = RxList<PostsModel>();

    uidList.forEach((element) async {
      var _response = await firebaseFirestore
          .collection('all_posts')
          .doc(element)
          .collection('coments')
          .get();
      if (_response.size > 5) {
        var _filteredResponse =
            await firebaseFirestore.collection('all_posts').doc(element).get();
        _list.add(PostsModel.fromJson(_filteredResponse.data()));
      }
    });
    return _list;
  }

  Future<UserModel> getOtherUserInformation(PostsModel model) async {
    isLoading.value = true;
    try {
      var response =
          await firebaseFirestore.collection('users').doc(model.user_id).get();

      UserModel otherUserModel = UserModel.fromJson(response.data());
      isLoading.value = false;
      return otherUserModel;
    } catch (e) {
      isLoading.value = false;
      return null;
    }
  }
}
