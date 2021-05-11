import 'dart:io';

import 'package:amigos_online/data/repository/cadastro_repository/cadastro_repository.dart';
import 'package:amigos_online/data/repository/cadastro_repository/nick_name_firebase_repository.dart';
import 'package:amigos_online/data/repository/cadastro_repository/user_avatar_repository.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';

class CadastroController extends GetxController {
  CadastroController(
      {@required this.cadastroRepository,
      @required this.nickNameFirebaseRepository,
      @required this.userAvatarRepository});
  CadastroRepository cadastroRepository;
  final UserAvatarRepository userAvatarRepository;
  final NickNameFirebaseRepository nickNameFirebaseRepository;
  List<String> errorsList = ["", "", "", "", ""].obs;
  Rx<File> image = Rx<File>();
  var verificationImage;
  final picker = ImagePicker();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> senhaController = TextEditingController().obs;
  Rx<TextEditingController> apelidoController = TextEditingController().obs;

  var loading = false.obs;

  Future cadastrar() async {
    loading.value = true;
    print("${emailController.value.text} e ${senhaController.value.text}");

    try {
      var response = await cadastroRepository.cadastrar(
          emailController.value.text, senhaController.value.text);
      print("$response Value aq");

      await createNick(
          apelido: apelidoController.value.text, id: response.user.uid);

      await userAvatarRepository.setUserImage(
          file: image.value, id: response.user.uid);
      loading.value = false;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      loading.value = false;
      SnackBar(content: Text("Ops, algo deu errado"));
    }
  }

  Future createNick({@required String apelido, @required String id}) async {
    var response =
        await nickNameFirebaseRepository.createNick(apelido: apelido, id: id);
  }

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
            Get.snackbar('Ops!', 'Apelido inválido');
          }
        } else {
          Get.snackbar('Ops!', 'Senha inválida');
          errorsList[1] = "A senha não pode ter menos do que 5 digitos";
          return false;
        }
        errorsList[0] = null;
        return false;
      } else {
        errorsList[0] = "Insira um email valido";
        Get.snackbar('Ops!', 'Insira um email válido');
        return false;
      }
    } else {
      Get.snackbar('Ops!', 'Insira uma imagem');
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
