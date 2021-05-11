import 'package:amigos_online/data/models/posts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostsItemController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  int comentsCount;
  PostsModel postsModel;

  @override
  void onInit() async {
    //Function here
    super.onInit();
  }

  Future<String> getImageFromUser(PostsModel model) async {
    var response =
        await firebaseFirestore.collection('users').doc(model.user_id).get();
    var value = response.data()['user_image'];
    return value;
  }

  Future<String> getNumberOfComents(PostsModel model) async {
    try {
      var response = await firebaseFirestore
          .collection('users')
          .doc(model.user_id)
          .collection('posts')
          .doc(model.uid)
          .collection('coments')
          .get();
      int _comentsCount = 0;
      response.docs.forEach((element) {
        _comentsCount++;
      });

      return _comentsCount.toString();
    } catch (e) {
      return null;
    }
  }
}
