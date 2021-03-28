import 'dart:io';

import 'package:amigos_online/utils/consts/consts_url.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar({this.image});
  final File image;
  @override
  Widget build(BuildContext context) {
    return image == null
        ? Padding(
            padding: EdgeInsets.all(12),
            child: Container(
                height: 140,
                width: 140,
                child: Image.network(
                  ConstsUrl.avatarImage,
                  fit: BoxFit.cover,
                )),
          )
        : Padding(
            padding: EdgeInsets.all(12),
            child: Container(
                height: 140,
                width: 140,
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                )),
          );
  }
}
