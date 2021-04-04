import 'dart:io';

import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/ui/components/signup_components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({@required this.model, @required this.controller, @required this.isOwnProfile});
  final UserProfileController controller;
  final UserModel model;
  final bool isOwnProfile;


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
                UserAvatar(
                  isNetworkImage: true,
                  networkImage: model.user_image,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => controller.hasNameLoaded.value
                        ? Text(controller.userName.value,
                            style: TextStyle(color: Colors.black, fontSize: 25))
                        : Text("Usuario")),
                   isOwnProfile ? IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: controller.openDialogToChangeName,
                      color: Colors.red,
                    ) : SizedBox(height: 0,)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
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
                              ? Text(controller.userPostsCount.value.toString(),
                                  style: TextStyle(color: Colors.black))
                              : Text(""))
                        ],
                      )
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