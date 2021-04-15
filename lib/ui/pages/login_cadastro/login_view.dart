import 'package:amigos_online/controller/login_controller/login_controller.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/generic_components/generic_button.dart';
import 'package:amigos_online/ui/components/generic_components/text_field_generic.dart';
import 'package:amigos_online/utils/generic_utils/keyboard_is_open.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Expanded(
                child: SafeArea(
                    child: Center(
                        child: Text(
              "AMIGOS\n  ONLINE",
              style: TextStyle(fontFamily: "Quantum", fontSize: 40),
            )))),
            Container(
              height: KeyBoardIsOpen.check(context) ? null : Get.height * 0.65,
              padding: KeyBoardIsOpen.check(context)
                  ? EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16)
                  : EdgeInsets.only(top: 16, bottom: 50, left: 16, right: 16),
              width: Get.width,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.green, blurRadius: 5)],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.black87),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GenericTextField(
                      hasHint: true,
                      textHint: "Email",
                      controller: controller.emailController),
                  Divider(
                    color: Colors.transparent,
                  ),
                  GenericTextField(
                      hasHint: true,
                      isPassword: true,
                      textHint: "Senha",
                      controller: controller.senhaController),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      height: 40,
                      child: GenericButton(
                          shadowColor: Colors.white,
                          onPressed: () {},
                          title: "Logar")),
                  Divider(),
                  Text(
                    "Ou",
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  SizedBox(
                      height: 40,
                      child: GenericButton(
                          shadowColor: Colors.white,
                          buttonColor: Colors.red,
                          onPressed: () => Get.toNamed(Routes.CADASTRO),
                          title: "Cadastrar")),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Esqueci a senha",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
