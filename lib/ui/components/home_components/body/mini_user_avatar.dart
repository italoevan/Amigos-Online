
import 'package:flutter/material.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:get/get.dart';

class MiniUserAvatar extends StatelessWidget {
  MiniUserAvatar({ this.controller, this.onTap, this.hasNetworkImage, this.networkImage});

  final Function onTap;
  final UserProviderController controller;
  final bool hasNetworkImage;
  final String networkImage;
  @override
  Widget build(BuildContext context) {
    return   hasNetworkImage == null ? Obx(() => controller.modelHasLoaded.value
        ? InkWell(
            onTap: onTap,
            child: Container(
                height: 45,
                width: 45,
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(controller.userModel.user_image),
                  backgroundColor: Colors.grey,
                )),
          )
        : Container()) :  Container(
                height: 45,
                width: 45,
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(networkImage),
                  backgroundColor: Colors.grey,
                )); 
  }
}
