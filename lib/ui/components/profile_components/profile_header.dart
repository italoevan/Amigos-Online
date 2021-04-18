import 'dart:async';
import 'dart:io';

import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/ui/components/generic_components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader(
      {@required this.model,
      @required this.controller,
      @required this.isOwnProfile});
  final UserProfileController controller;
  final UserModel model;
  final bool isOwnProfile;
  var animateContainer = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(32),
            height: Get.height * 0.30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [BoxShadow(color: Colors.green, blurRadius: 6)],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.dialog(AlertDialog(
                      contentPadding: EdgeInsets.all(0),
                      content: Container(
                        width: Get.width * 0.8,
                        height: Get.height * 0.5,
                        child: Image.network(
                          model.user_image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
                  },
                  child: UserAvatar(
                    borderColor: Colors.green,
                    hasBorder: true,
                    isNetworkImage: true,
                    networkImage: model.user_image,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => controller.hasNameLoaded.value
                        ? Text(controller.userName.value,
                            style: TextStyle(color: Colors.black, fontSize: 25))
                        : Text("Usuario")),
                    isOwnProfile
                        ? IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: controller.openDialogToChangeName,
                            color: Colors.red,
                          )
                        : SizedBox(
                            height: 0,
                          )
                  ],
                ),
                Container(
                  height: 65,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.black),
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Posts:",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Obx(() => controller.hasPostCountLoaded.value
                                      ? Text(
                                          controller.userPostsCount.value
                                              .toString(),
                                          style: TextStyle(color: Colors.black))
                                      : Text(""))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  highlightColor: Colors.red,
                                  onTap: () {
                                    animateContainer.value = true;
                                    Timer(Duration(milliseconds: 100),
                                        () => animateContainer.value = false);
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    height: animateContainer.value ? 40 : 50,
                                    width: animateContainer.value ? 40 : 50,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7,
                                              color: Colors.black)
                                        ],
                                        border: Border.all(color: Colors.green),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Image.asset(
                                      'assets/images/social_network.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
