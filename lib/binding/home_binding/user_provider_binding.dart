import 'package:amigos_online/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserProviderBinding implements Bindings {
  @override
  void dependencies() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    Get.lazyPut<UserProviderController>(
        () => UserProviderController(auth: auth, firestore: firestore));
  }
}
