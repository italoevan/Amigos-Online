import 'dart:async';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amigos_online/ui/pages/login_cadastro/login_view.dart';
import 'package:amigos_online/ui/pages/home/home_view.dart';

class SplashController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();

    verifyUserConnection().then((value) => {
          Timer(Duration(seconds: 2), () {
            if (value) {
              Get.offAll(HomeView());
            } else {
              Get.offAll(LoginView());
            }
          })
        });
  }

  Future<bool> verifyUserConnection() async {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
