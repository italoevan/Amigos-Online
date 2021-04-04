import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var profileImageHasLoaded = false.obs;
  var isLoading = false.obs;

  Rx<TextEditingController> newPostController = TextEditingController().obs;
  var newPostMessageError = "".obs;

  UserProviderController userProviderController =
      Get.find<UserProviderController>();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxInt atualTagChoose = 0.obs;

  var userChose = "".obs;

  List<PostsModel> listPosts;
  var hasPostsLoaded = false.obs;

  UserModel userModel;
  @override
  void onInit() async {
    getUserInformation();
    hasPostsLoaded.value = await getHomePosts();
    super.onInit();
  }

  getUserInformation() async {
    await userProviderController.getUserInformations();
    userModel = userProviderController.userModel;
  }

  Future newPost() async {
    await getUserInformation();
    if (verification()) {
      isLoading.value = true;
      var atualDate = Timestamp.now();
      var date = atualDate.toDate();
      print(date);

      PostsModel postsModel = PostsModel();
      postsModel.user_id = userModel.user_id;
      postsModel.user_image = userModel.user_image;
      postsModel.tag = userChose.value;
      postsModel.content = newPostController.value.text;
      postsModel.user_name = userModel.name;
      postsModel.date = date.toString();
      postsModel.uid = date.toString();

      var modelJson = postsModel.toJson();

      try {
        await firebaseFirestore
            .collection('users')
            .doc(postsModel.user_id)
            .collection('posts')
            .doc(postsModel.date)
            .set(modelJson);

        await firebaseFirestore
            .collection("all_posts")
            .doc(postsModel.date)
            .set(modelJson);

        await refreshPostsCount(postsModel);

        Get.snackbar("OBA!", "Sucesso ao postar");
        newPostController.value.text = "";
        isLoading.value = false;
        hasPostsLoaded.value = false;
        hasPostsLoaded.value = await getHomePosts();
        return;
      } catch (e) {
        Get.snackbar("Atenção", "Erro: $e");
        isLoading.value = false;
        return;
      }
    }
  }

  Future<bool> getHomePosts() async {
    List<PostsModel> modelPostList = [];
    try {
      
      var response = await firebaseFirestore.collection("all_posts").orderBy('date', descending: true).get();

      response.docs.forEach((element) {
        print(element.data());
        modelPostList.add(PostsModel.fromJson(element.data()));
      });
      listPosts = modelPostList;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future refreshPostsCount(PostsModel postsModel) async {
    var postsCount = await firebaseFirestore
        .collection('users')
        .doc(postsModel.user_id)
        .get();

    String counter = postsCount.data()['n_posts'].toString();
    print(counter + "aAAAAAAAAAAAAAAAAAAAAA");
    print(counter);
    await firebaseFirestore
        .collection('users')
        .doc(postsModel.user_id)
        .update({'n_posts': int.parse(counter) + 1});
    return;
  }

  bool verification() {
    if (newPostController.value.text.length < 4) {
      newPostMessageError.value = "Erro";
      Get.snackbar("Atenção", "Não pode haver menos que 4 caracteres.");
      return false;
    } else if (newPostController.value.text.length > 75) {
      Get.snackbar("Atenção", "Não pode haver mais que 75 caracteres.");
      return false;
    } else if (atualTagChoose.value == 0) {
      Get.snackbar("Atenção", "Escolha uma tag.");
      newPostMessageError.value = "";
      return false;
    }
    newPostMessageError.value = "";
    return true;
  }

  openDialogToChooseTag() {
    showDialog(
      context: Get.context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: Obx(() => Container(
                    color: Colors.black26,
                    height: Get.height * 0.5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 1,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            Text("Amizade")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 2,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            Text("Amor")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 3,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            Text("Cotidiano")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 4,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            Text("Desabafo")
                          ],
                        )
                      ],
                    ))));
          },
        );
      },
    );
  }

  void changeRadioValue(int valor) {
    atualTagChoose.value = valor;

    switch (atualTagChoose.value) {
      case 1:
        userChose.value = "AMIZADE";

        break;

      case 2:
        userChose.value = "AMOR";

        break;

      case 3:
        userChose.value = "Cotidiano";
        break;

      case 4:
        userChose.value = "Desabafo";
        break;
      case 5:
        userChose.value = "Política";
        break;
      case 6:
        userChose.value = "Séries";
        break;
    }
  }
}
