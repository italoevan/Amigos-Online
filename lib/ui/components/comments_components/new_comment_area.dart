import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:amigos_online/ui/components/generic_components/text_field_generic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCommentArea extends StatelessWidget {
  NewCommentArea(
      {@required this.comentsController, @required this.newPostController, @required this.userProviderController});
  final UserProviderController userProviderController;
  final ComentsController comentsController;
  final TextEditingController newPostController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.12,
      child: Column(
        children: [
          Row(
            children: [
              MiniUserAvatar(
                hasNetworkImage: true,
                networkImage: userProviderController.userModel.user_image,
              ),
              VerticalDivider(),
              Expanded(child: GenericTextField(controller: newPostController))
            ],
          ),
        ],
      ),
    );
  }
}
