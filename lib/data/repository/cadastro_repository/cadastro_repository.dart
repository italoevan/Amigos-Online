import 'package:amigos_online/data/provider/cadastro_providers/cadastro_provider.dart';
import 'package:meta/meta.dart';

class CadastroRepository {
  final CadastroProvider provider;

  CadastroRepository({@required this.provider}) : assert(provider != null);

  Future cadastrar(String email, String senha) async {
    try {
      var response = await provider.cadastrar(email, senha);
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
