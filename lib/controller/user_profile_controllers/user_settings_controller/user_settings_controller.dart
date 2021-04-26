import 'package:amigos_online/data/models/social_network_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/ui/components/generic_components/generic_button.dart';
import 'package:amigos_online/utils/firebase_utils/get_atual_user_id.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:amigos_online/utils/generic_utils/social_network_image_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSettingsController extends GetxController {
  UserSettingsController(this.firestore) : assert(firestore != null);

  final FirebaseFirestore firestore;
  var isLoading = false.obs;

  showSocialNetworkDialog(BuildContext context) async {
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
    } else {
      socialNetworkModel = SocialNetworkModel();
    }

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
                            Expanded(
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
                            Expanded(
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
                            Expanded(
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
      _socialNetworkModel.whatsapp = int.parse(whatsapp);
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
}
