import 'package:amigos_online/data/provider/cadastro_providers/nickname_firebase_provider.dart';
import 'package:flutter/material.dart';

class NickNameFirebaseRepository {
  final NickNameProvider provider;

  NickNameFirebaseRepository({@required this.provider})
      : assert(provider != null);

  Future createNick({@required String apelido, @required String id}) async {
    try {
      var response = await provider.createNick(apelido: apelido, id: id);
      return response;
    } catch (e) {
      return e;
    }
  }
}
