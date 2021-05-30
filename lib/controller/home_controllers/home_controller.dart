import 'package:amigos_online/data/models/initial_dialog_moddel.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/ui/components/generic_components/tags/tags.dart';
import 'package:amigos_online/ui/components/home_components/initial_dialog/initial_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var newPostIsOpen = true.obs;

  UserModel userModel;

  PageController pageController = PageController(initialPage: 1);
  var atualPage = 1.obs;
  @override
  void onInit() async {
    getUserInformation();
    hasPostsLoaded.value = await getHomePosts();
    pageController.addListener(getAtualPage);
    getInitialDialog();
    super.onInit();
  }

  getAtualPage() {
    atualPage.value = pageController.page.toInt();
  }

  getUserInformation() async {
    await userProviderController.getUserInformations();
    userModel = userProviderController.userModel;
  }

  Future newPost(BuildContext context) async {
    await getUserInformation();
    if (verification()) {
      isLoading.value = true;
      var uid = Timestamp.now();
      var date = DateTime.now();
      print(uid);

      PostsModel postsModel = PostsModel();
      postsModel.user_id = userModel.user_id;
      postsModel.tag = userChose.value;
      postsModel.content = newPostController.value.text;
      postsModel.user_name = userModel.name;
      postsModel.date = date.toString();
      postsModel.uid = uid.toString();

      var modelJson = postsModel.toJson();

      try {
        await firebaseFirestore
            .collection('users')
            .doc(postsModel.user_id)
            .collection('posts')
            .doc(postsModel.uid)
            .set(modelJson);

        await firebaseFirestore
            .collection("all_posts")
            .doc(postsModel.uid)
            .set(modelJson);

        await refreshPostsCount(postsModel);
        atualTagChoose.value = 0;
        Get.back();
        Get.snackbar("OBA!", "Sucesso ao postar");
        newPostController.value.text = "";
        FocusScope.of(context).unfocus();
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
    try {
      var response = await firebaseFirestore
          .collection("all_posts")
          .orderBy("uid", descending: true)
          .get();
      List<PostsModel> modelPostList = [];

      response.docs.forEach((element) {
        modelPostList.add(PostsModel.fromJson(element.data()));
      });

      listPosts = modelPostList;

      return true;
    } catch (e) {
      return false;
    }
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

  Future refreshPostsCount(PostsModel postsModel) async {
    var postsCount = await firebaseFirestore
        .collection('users')
        .doc(postsModel.user_id)
        .get();

    String counter = postsCount.data()['n_posts'].toString();

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
                            GestureDetector(
                                onTap: () => changeRadioValue(1),
                                child: Text(Tags.tagsList[0]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 2,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            GestureDetector(
                                onTap: () => changeRadioValue(2),
                                child: Text(Tags.tagsList[1]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 3,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            GestureDetector(
                                onTap: () => changeRadioValue(3),
                                child: Text(Tags.tagsList[2]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 4,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            GestureDetector(
                                onTap: () => changeRadioValue(4),
                                child: Text(Tags.tagsList[3]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 5,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            GestureDetector(
                                onTap: () => changeRadioValue(5),
                                child: Text(Tags.tagsList[4]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 6,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            GestureDetector(
                                onTap: () => changeRadioValue(6),
                                child: Text(Tags.tagsList[5]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: 7,
                                groupValue: atualTagChoose.value,
                                onChanged: changeRadioValue),
                            GestureDetector(
                                onTap: () => changeRadioValue(7),
                                child: Text(Tags.tagsList[6]))
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 110,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      primary: Colors.blueAccent),
                                  onPressed: () => Get.back(),
                                  child: Text("Pronto")),
                            ),
                          ),
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
        userChose.value = Tags.tagsList[0];

        break;

      case 2:
        userChose.value = Tags.tagsList[1];

        break;

      case 3:
        userChose.value = Tags.tagsList[2];
        break;

      case 4:
        userChose.value = Tags.tagsList[3];
        break;
      case 5:
        userChose.value = Tags.tagsList[4];
        break;
      case 6:
        userChose.value = Tags.tagsList[5];
        break;
      case 7:
        userChose.value = Tags.tagsList[6];
        break;
    }
  }

  String defineAtualPage() {
    if (atualPage.value == 0) {
      return 'EM ALTA';
    }

    if (atualPage.value == 1) {
      return 'HOME';
    }

    if (atualPage.value == 2) {
      return 'SEGUINDO';
    }

    if (atualPage.value == 3) {
      return 'PESQUISAR';
    }
    return 'a';
  }

  getInitialDialog() async {
    var response = await firebaseFirestore
        .collection('remote_configurations')
        .doc('remote_configurations')
        .get();

    InitialDialogModel _model = InitialDialogModel.fromJson(response.data());

    if (_model.dialogModel.hasInitialDialog) {
      Get.dialog(InitialDialogView(_model));
    } else {
      DoNothingAction();
    }
  }
}
