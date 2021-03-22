import 'package:amigos_online/data/repository/cadastro_repository/cadastro_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CadastroController extends GetxController {
  CadastroController({@required this.repository});
  CadastroRepository repository;
  List<String> errorsList = ["", "", "", ""].obs;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> senhaController = TextEditingController().obs;
  Rx<TextEditingController> apelidoController = TextEditingController().obs;

  Future cadastrar() {
    //repository.cadastrar(email, senha);
  }

  bool validate() {
    if (GetUtils.isEmail(emailController.value.text)) {
      if (senhaController.value.text.length > 5) {
        if (apelidoController.value.text.length > 4) {
          errorsList[2] = null;
          return true;
        } else {
          errorsList[2] = 'O apelido tem que ter mais do que 4 caracteres';
          Get.snackbar('Error', 'Apelido inválido');
        }
        errorsList[1] = null;
      } else {
        Get.snackbar('Error', 'Senha inválida');
        errorsList[1] = "A senha não pode ter menos do que 5 digitos";
      }
      errorsList[0] = null;
    } else {
      errorsList[0] = "Insira um email valido";
      Get.snackbar('Error', 'Insira um email válido');
      return false;
    }
  }
}
