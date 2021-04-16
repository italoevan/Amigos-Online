import 'package:amigos_online/controller/login_controller/login_controller.dart';
import 'package:amigos_online/data/provider/login_provider/login_provider.dart';
import 'package:amigos_online/data/repository/login_repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    FirebaseAuth auth = FirebaseAuth.instance;
    LoginProvider provider = LoginProvider(auth: auth);
    LoginRepository repository = LoginRepository(provider);

    Get.lazyPut<LoginController>(() => LoginController(repository: repository));
  }
}
