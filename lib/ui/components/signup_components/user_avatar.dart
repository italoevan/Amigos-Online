import 'dart:io';

import 'package:amigos_online/utils/consts/consts_url.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar({this.image, this.networkImage, this.isNetworkImage});
  final File image;
  final String networkImage;
  bool isNetworkImage = false;
  @override
  Widget build(BuildContext context) {
    return isNetworkImage
        ? Padding(
            padding: EdgeInsets.all(5),
            child: Container(
                height: 125,
                width: 125,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(networkImage, fit: BoxFit.cover,),
                )),
          )
        : image == null
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                      ),
                    )),
              );
  }
}
