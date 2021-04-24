import 'dart:io';

import 'package:amigos_online/utils/consts/consts_url.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar(
      {this.image,
      this.networkImage,
      this.isNetworkImage,
      this.isMiniAvatar,
      this.hasBorder,
      this.borderColor,
      this.boxFit});
  final File image;
  final String networkImage;
  final BoxFit boxFit;
  final Color borderColor;
  bool hasBorder = false;
  bool isMiniAvatar = false;
  bool isNetworkImage = false;
  @override
  Widget build(BuildContext context) {
    return isNetworkImage
        ? Padding(
            padding: EdgeInsets.all(5),
            child: Container(
                decoration: hasBorder == true
                    ? BoxDecoration(
                        border: Border.all(
                            color: borderColor != null
                                ? borderColor
                                : Colors.black),
                        borderRadius: BorderRadius.circular(100))
                    : null,
                height: isMiniAvatar == true ? 50 : 125,
                width: isMiniAvatar == true ? 50 : 125,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    networkImage,
                    height: isMiniAvatar == true ? 50 : 125,
                    width: isMiniAvatar == true ? 50 : 125,
                    fit: boxFit != null ? boxFit : BoxFit.cover,
                  ),
                )),
          )
        : image == null
            ? Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                    height: isMiniAvatar == true ? 50 : 140,
                    width: isMiniAvatar == true ? 50 : 140,
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
