import 'package:amigos_online/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProviderController extends GetxController {
  UserProviderController({@required this.firestore, @required this.auth});

  UserModel userModel;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  var modelHasLoaded = false.obs;

  @override
  void onInit() async {
    modelHasLoaded.value = await getUserInformations();
    super.onInit();
  }

  Future<bool> getUserInformations() async {
    String uid = await getUserId();

    var response = await firestore.collection('users').doc(uid).get();

    UserModel model = UserModel.fromJson(response.data());

    print(model.user_image);
    userModel = model;
    return true;
  }

  Future<String> getUserId() async {
    String response = await auth.currentUser.uid;
    return response;
  }
}
