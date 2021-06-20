import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/ui/components/profile_components/posts_area.dart';
import 'package:amigos_online/ui/components/profile_components/profile_header.dart';
import 'package:amigos_online/utils/generic_utils/hex_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  final bool isOwnProfile = Get.arguments["isOwnProfile"];
  final UserProfileController userController =
      Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    isOwnProfile ? print("Perfil próprio") : print("Perfil de algum user");

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "PERFIL",
            style: TextStyle(fontFamily: 'Quantum'),
          ),
        ),
        body: isOwnProfile == true
            ? Container(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: userController.model.value
                                                .customizedProfile !=
                                            null &&
                                        userController.model.value
                                                .customizedProfile ==
                                            true
                                    ? HexConverter.toColor(userController.model.value.hexColor)
                                    : Colors.lightGreen,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(32),
                                    bottomLeft: Radius.circular(32))),
                            height: Get.height * 0.25,
                          )
                        ],
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        ProfileHeader(
                          isOwnProfile: isOwnProfile,
                          controller: userController,
                          model: userController.model.value,
                        ),
                        PostsArea(controller: userController)
                      ],
                    ))
                  ],
                ),
              )
            : Container(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: userController.model.value
                                                .customizedProfile !=
                                            null &&
                                        userController.model.value
                                                .customizedProfile ==
                                            true
                                    ? HexConverter.toColor(userController.model.value.hexColor)
                                    : Colors.lightGreen,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(32),
                                    bottomLeft: Radius.circular(32))),
                            height: Get.height * 0.25,
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: Get.height,
                        width: Get.width,
                        child: Column(
                          children: [
                            Obx(
                              () => ProfileHeader(
                                isOwnProfile: isOwnProfile,
                                controller: userController,
                                model: userController.model.value,
                              ),
                            ),
                            Expanded(
                              child: PostsArea(
                                controller: userController,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ));
  }
}
