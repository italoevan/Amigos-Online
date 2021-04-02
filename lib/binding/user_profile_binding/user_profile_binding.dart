import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:get/get.dart';

class UserProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}
