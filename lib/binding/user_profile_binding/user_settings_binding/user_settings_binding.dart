import 'package:amigos_online/controller/user_profile_controllers/user_settings_controller/user_settings_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserSettingsBinding implements Bindings {
  @override
  void dependencies() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Get.lazyPut<UserSettingsController>(() => UserSettingsController(firestore));
  }
}
