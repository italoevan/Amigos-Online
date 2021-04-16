import 'package:amigos_online/data/provider/login_provider/login_provider.dart';
import 'package:flutter/material.dart';

class LoginRepository {
  LoginRepository(this.provider);
  final LoginProvider provider;

  Future signIn({@required String email, @required String password}) async {
    try{
    var response = await provider.signIn(email: email, password: password);
    return response;
    }catch(e){
      return throw Exception(e.toString());
    }
  }
}
