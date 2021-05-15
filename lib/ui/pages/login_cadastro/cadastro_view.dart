import 'dart:io';

import 'package:amigos_online/controller/cadastro_controller/cadastro_controller.dart';
import 'package:amigos_online/ui/components/generic_components/generic_button.dart';
import 'package:amigos_online/ui/components/signup_components/signup_divider.dart';
import 'package:amigos_online/ui/components/generic_components/user_avatar.dart';
import 'package:amigos_online/utils/generic_utils/keyboard_is_open.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:amigos_online/ui/components/generic_components/text_field_generic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroView extends StatelessWidget {
  final CadastroController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
        appBar: KeyBoardIsOpen.check(context)
            ? null
            : AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Obx(() => LoadingUtil(
              loading: controller.loading.value,
              widget: Container(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      child: SafeArea(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => GestureDetector(
                                    onTap: () => controller.chooseImage(),
                                    child: UserAvatar(
                                      isMiniAvatar: false,
                                      isNetworkImage: false,
                                      image: controller.image.value == null
                                          ? null
                                          : controller.image.value,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: KeyBoardIsOpen.check(context)
                          ? EdgeInsets.only(
                              top: 16, bottom: 8, left: 16, right: 16)
                          : EdgeInsets.only(
                              top: 16, bottom: 50, left: 16, right: 16),
                    
                      width: Get.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.green, blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          color: Colors.black87),
                      child: Column(
                        children: [
                          Obx(() => GenericTextField(
                                hasHint: true,
                                textHint: 'Email',
                                controller: controller.emailController.value,
                                error: controller.errorsList[0],
                              )),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Obx(() => GenericTextField(
                                hasHint: true,
                                isPassword: true,
                                textHint: 'Senha',
                                controller: controller.senhaController.value,
                                error: controller.errorsList[1],
                              )),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Obx(() => GenericTextField(
                                hasHint: true,
                                textHint: 'Apelido',
                                controller: controller.apelidoController.value,
                                error: controller.errorsList[2],
                              )),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GenericButton(
                                  onPressed: () {
                                    controller.validate()
                                        ? controller.cadastrar()
                                        : print('nao ok');
                                  },
                                  title: "Cadastrar"),
                              GenericButton(
                                  buttonColor: Colors.red,
                                  onPressed: () => controller.chooseImage(),
                                  title: "Escolher Imagem")
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
