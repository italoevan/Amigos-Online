import 'package:amigos_online/ui/components/generic_components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:get/get.dart';

class MiniUserAvatar extends StatelessWidget {
  MiniUserAvatar({@required this.controller, this.onTap});

  final Function onTap;
  final UserProviderController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.modelHasLoaded.value
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
        : Container());
  }
}
