import 'package:amigos_online/data/repository/cadastro_repository/cadastro_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CadastroController extends GetxController {
  CadastroController({@required this.repository});
  CadastroRepository repository;

  Future cadastrar() {
    //repository.cadastrar(email, senha);
  }
}
