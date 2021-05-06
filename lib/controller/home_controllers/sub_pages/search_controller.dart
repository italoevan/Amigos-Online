import 'package:amigos_online/data/models/posts_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<PostsModel> postsModel = RxList<PostsModel>();
  int atualIndice;
  Future getSearchedPosts(String value) async {
    clean();

    if (textEditingController.text.isNotEmpty) {
      postsModel.refresh();
      var response = await firebaseFirestore
          .collection('all_posts')
          .where('content',
              isGreaterThanOrEqualTo: textEditingController.value.text)
          .where('content',
              isLessThanOrEqualTo: textEditingController.value.text + 'z')
          .get();

      print(response.size);

      response.docs.forEach((element) {
        String value = element.data()['uid'];
        if (!isRedundant(value)) {
          postsModel.add(PostsModel.fromJson(element.data()));
        } else {
          postsModel.removeAt(atualIndice);
          postsModel.refresh();
        }

        return;
      });
    }
  }

  bool isRedundant(String uid) {
    for (int i = 0; i < postsModel.length; i++) {
      if (postsModel[i].uid == uid) {
        atualIndice = i;
        postsModel.refresh();

        return true;
      }
      return false;
    }
    return false;
  }

  clean() {
    postsModel.clear();
    postsModel.refresh();
  }
}
