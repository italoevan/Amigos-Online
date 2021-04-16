import 'package:amigos_online/data/repository/login_repository/login_repository.dart';
import 'package:amigos_online/routes/app_routes.dart';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController({@required this.repository});
  final LoginRepository repository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  var isLoading = false.obs;

  Future signIn(BuildContext context) async {
    if (verification()) {
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      try {
        await repository.signIn(
            email: emailController.text, password: senhaController.text);
        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.snackbar(
            "Atenção", "Verifique o email e a senha e tente novamente.");
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
    }
  }

  bool verification() {
    if (emailController.text != null &&
        GetUtils.isEmail(emailController.text) &&
        emailController.text.isNotEmpty) {
      if (senhaController.text != null && senhaController.text.isNotEmpty) {
        return true;
      } else {
        Get.snackbar("Atenção", "Senha incorreto.");
        return false;
      }
    } else {
      Get.snackbar("Atenção", "Email incorreta.");
      return false;
    }
  }
}
