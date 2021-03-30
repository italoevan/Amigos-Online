import 'dart:io';

import 'package:amigos_online/controller/cadastro/cadastro_controller.dart';
import 'package:amigos_online/ui/components/signup_components/signup_divider.dart';
import 'package:amigos_online/ui/components/signup_components/user_avatar.dart';
import 'package:amigos_online/utils/generic_utils/text_field_generic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroView extends StatelessWidget {
  final CadastroController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Obx(() => UserAvatar(
                  image: controller.image.value == null
                      ? null
                      : controller.image.value,
                )),
            SignupDivider(),
            Container(
              child: Container(
                margin: EdgeInsets.all(Get.width * 0.05),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                            onPressed: () {
                              controller.validate()
                                  ? controller.cadastrar()
                                  : print('nao ok');
                            },
                            child: Text("Cadastrar")),
                        RaisedButton(
                          onPressed: () => controller.chooseImage(),
                          child: Text("Escolher imagem"),
                        )
                      ],
                    )
                  ],
                ),
                //color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
