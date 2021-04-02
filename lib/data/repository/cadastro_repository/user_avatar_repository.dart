import 'dart:io';

import 'package:amigos_online/data/provider/cadastro_providers/user_avatar_provider.dart';
import 'package:flutter/material.dart';

class UserAvatarRepository {
  UserAvatarRepository({@required this.provider});

  final UserAvatarProvider provider;

  Future setUserImage({@required File file, @required String id}) async {
    var link = await provider.setUserImage(file: file, id: id);
    return link;
  }
}
