import 'dart:math';

import 'package:amigos_online/data/models/social_network_model.dart';
import 'package:amigos_online/data/models/user_colors_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/ui/components/generic_components/generic_button.dart';
import 'package:amigos_online/ui/components/profile_components/profile_settings_components/change_photo_component.dart';
import 'package:amigos_online/ui/pages/user_profile/user_settings/color_choose/color_grid.dart';
import 'package:amigos_online/utils/firebase_utils/get_atual_user_id.dart';
import 'package:amigos_online/utils/generic_utils/social_network_image_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserSettingsController extends GetxController {
  UserSettingsController(this.firestore) : assert(firestore != null);

  final FirebaseFirestore firestore;
  var isLoading = false.obs;
  var isUserCHoice = false.obs;

  var changePhotoIsLoading = false.obs;

  final picker = ImagePicker();
  Rx<File> _image = Rx<File>();
  String urlUserImage;

  @override
  void onInit() async {
    urlUserImage = await getUrlProfileImage();
    super.onInit();
  }

  showSocialNetworkDialog(BuildContext context) async {
    var form = GlobalKey<FormState>();

    isLoading.value = true;
    SocialNetworkModel socialNetworkModel;
    String userId = GetAtualUserId().getUserId();
    var response = await firestore
        .collection('users')
        .doc(userId)
        .collection('social_network')
        .doc('social_network')
        .get();

    if (response.data() != null) {
      socialNetworkModel = SocialNetworkModel.fromJson(response.data());

      if (response.data()['whatsapp'] != null &&
          response.data()['whatsapp'].toString() != "") {
        int value =
            int.parse(socialNetworkModel.whatsapp.toString().replaceFirst(
                  new RegExp('55'),
                  '',
                ));
        socialNetworkModel.whatsapp = value;
      }
    } else {
      socialNetworkModel = SocialNetworkModel();
    }

    TextEditingController _ddi = TextEditingController(
      text: '+55',
    );

    TextEditingController _arroba = TextEditingController(text: '   @');

    TextEditingController _whatsapp = TextEditingController(
        text: socialNetworkModel.whatsapp != null
            ? socialNetworkModel.whatsapp.toString()
            : "");
    TextEditingController _twitter = TextEditingController(
        text: socialNetworkModel.twitter != null
            ? socialNetworkModel.twitter
            : "");
    TextEditingController _instagram = TextEditingController(
        text: socialNetworkModel.instagram != null
            ? socialNetworkModel.instagram
            : "");
    Map<String, dynamic> imageLink = await SocialNetworkProvider.getImages();
    isLoading.value = false;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18),
                        topLeft: Radius.circular(18))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                imageLink['whatsapp'],
                                height: 55,
                                width: 55,
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: TextField(
                                    style: TextStyle(color: Colors.black38),
                                    controller: _ddi,
                                    enabled: false)),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: _whatsapp,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Image.network(
                              imageLink['twitter'],
                              fit: BoxFit.cover,
                              height: 70,
                              width: 70,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                  style: TextStyle(color: Colors.black38),
                                  controller: _arroba,
                                  enabled: false),
                            ),
                            Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: _twitter,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Image.network(
                              imageLink['instagram'],
                              height: 70,
                              width: 70,
                            ),
                            Flexible(
                              child: TextField(
                                style: TextStyle(color: Colors.black38),
                                controller: _arroba,
                                enabled: false,
                              ),
                            ),
                            Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: _instagram,
                                ))
                          ],
                        ),
                        SizedBox(
                            width: Get.width * 0.5,
                            child: GenericButton(
                              onPressed: () async {
                                await updateSocialNetwork(
                                        atualuser: userId,
                                        whatsapp: _whatsapp.value.text.isEmpty
                                            ? null
                                            : _whatsapp.value.text,
                                        twitter: _twitter.value.text.isEmpty
                                            ? null
                                            : _twitter.value.text,
                                        instagram: _instagram.value.text.isEmpty
                                            ? null
                                            : _instagram.value.text)
                                    .then((value) {
                                  if (value) {
                                    Get.back();
                                    Get.snackbar('Opa!!',
                                        'Você atualizou suas informações');
                                  }
                                });
                              },
                              title: 'Salvar',
                              buttonColor: Colors.red,
                            ))
                      ],
                    ),
                  ],
                )),
          );
        });
  }

  Future<bool> updateSocialNetwork(
      {String whatsapp,
      String twitter,
      String instagram,
      String atualuser}) async {
    SocialNetworkModel _socialNetworkModel = SocialNetworkModel();

    if (whatsapp != null) {
      _socialNetworkModel.whatsapp = int.parse('55$whatsapp');
    }
    if (twitter != null) {
      _socialNetworkModel.twitter = twitter;
    }
    if (instagram != null) {
      _socialNetworkModel.instagram = instagram;
    }

    var jsonModel = _socialNetworkModel.toJson();

    try {
      await firestore
          .collection('users')
          .doc(atualuser)
          .collection('social_network')
          .doc('social_network')
          .set(jsonModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getUrlProfileImage() async {
    var response = await firestore
        .collection('users')
        .doc(GetAtualUserId().getUserId())
        .get();
    var url = response.data()['user_image'];
    return url;
  }

  openCardWithProfileImage() async {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: Get.width * 0.8,
        height: Get.height * 0.5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(
              () => _image.value == null
                  ? Image.network(
                      urlUserImage,
                      fit: BoxFit.cover,
                      width: Get.width * 0.8,
                      height: Get.height * 0.5,
                    )
                  : Image.file(
                      _image.value,
                      fit: BoxFit.cover,
                      width: Get.width * 0.8,
                      height: Get.height * 0.5,
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.green,
                  ),
                  onPressed: getImage),
            ),
            Obx(
              () => Visibility(
                visible: isNewPhoto,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChangePhotoItem(
                          onTap: () {
                            _image.value = null;
                            Get.back();
                          },
                          buttonColor: Colors.red,
                          iconData: Icons.remove_circle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ChangePhotoItem(
                          onTap: () => savePhotoOnStorage(),
                          buttonColor: Colors.blue,
                          iconData: Icons.check_circle,
                        )
                      ]),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                  visible: changePhotoIsLoading.value,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
            )
          ],
        ),
      ),
    ));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    } else {
      Get.snackbar('Ops!', 'Você não selecionou nenhuma imagem.');
    }
  }

  bool get isNewPhoto => _image.value != null;

  savePhotoOnStorage() async {
    changePhotoIsLoading.value = true;
    FirebaseStorage storage = FirebaseStorage.instance;

    var reference = await storage
        .ref()
        .child('/profile_images')
        .child(GetAtualUserId().getUserId())
        .putFile(_image.value);
    var link = await reference.ref.getDownloadURL();
    Map<String, dynamic> map = {"user_image": link};

    await firestore
        .collection('users')
        .doc(GetAtualUserId().getUserId())
        .update(map);
    print(link);
    changePhotoIsLoading.value = false;
    DartNotificationCenter.post(channel: 'profileIMage', options: link);
    DartNotificationCenter.post(channel: 'profilePosts', options: link);

    Get.back();

    Get.snackbar('Parabéns', 'Sucesso ao trocar!!');
    return link;
  }

  Future<GridColorsModel> getColorsModel() async {
    var response =
        await firestore.collection('users_colors').doc('colors').get();
    GridColorsModel model = GridColorsModel.fromJson(response.data());
    print(model.colors.listColors.length);
    return model;
  }

  void openProfileAlert() async {
    Get.dialog(AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content:
          ColorGrid(onTap: changeProfileColor, model: await getColorsModel()),
    ));
  }

  void changeProfileColor(String hex) async {
    await firestore
        .collection('users')
        .doc(GetAtualUserId().getUserId())
        .update({'customizedProfile': true, 'hexColor': hex});

    DartNotificationCenter.post(
        channel: 'profileBackgroundColor', options: hex);
    Get.back();
  }
}
