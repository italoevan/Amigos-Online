import 'package:amigos_online/controller/cadastro/cadastro_controller.dart';
import 'package:amigos_online/data/provider/cadastro_provider/cadastro_provider.dart';
import 'package:amigos_online/data/repository/cadastro_repository/cadastro_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CadastroBinding implements Bindings {
  @override
  void dependencies() {
    FirebaseAuth auth = FirebaseAuth.instance;
    Get.lazyPut<CadastroController>(() => CadastroController(
        repository:
            CadastroRepository(provider: CadastroProvider(auth: auth))));
  }
}
