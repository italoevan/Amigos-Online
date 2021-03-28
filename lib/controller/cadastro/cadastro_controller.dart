import 'dart:io';

import 'package:amigos_online/data/repository/cadastro_repository/cadastro_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';

class CadastroController extends GetxController {
  CadastroController({@required this.repository});
  CadastroRepository repository;
  List<String> errorsList = ["", "", "", "", ""].obs;
  Rx<File> image = Rx<File>();
  var verificationImage;
  final picker = ImagePicker();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> senhaController = TextEditingController().obs;
  Rx<TextEditingController> apelidoController = TextEditingController().obs;

  Future cadastrar() async {
    var response = await repository.cadastrar(
        emailController.value.text, senhaController.value.text);
  }

  userFirestoreRegister() {}

  bool validate() {
    if (verificationImage != null) {
      if (GetUtils.isEmail(emailController.value.text)) {
        errorsList[0] = null;
        if (senhaController.value.text.length > 5) {
          errorsList[1] = null;
          if (apelidoController.value.text.length > 4) {
            errorsList[2] = null;
            return true;
          } else {
            errorsList[2] = 'O apelido tem que ter mais do que 4 caracteres';
            Get.snackbar('Error', 'Apelido inválido');
          }
        } else {
          Get.snackbar('Error', 'Senha inválida');
          errorsList[1] = "A senha não pode ter menos do que 5 digitos";
          return false;
        }
        errorsList[0] = null;
        return false;
      } else {
        errorsList[0] = "Insira um email valido";
        Get.snackbar('Error', 'Insira um email válido');
        return false;
      }
    } else {
      Get.snackbar('Error', 'Insira uma imagem');
      return false;
    }
  }

  Future chooseImage() async {
    File _image;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      image.value = _image;
      verificationImage = "noNull";
    } else {
      if (verificationImage != null) {
        verificationImage = null;
      }
      Get.snackbar('Atenção', 'Você não selecionou nenhuma imagem');
    }
  }
}
