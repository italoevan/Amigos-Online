import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/ui/components/profile_components/profile_header.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  final UserModel model = Get.arguments["userModel"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PERFIL"),
        ),
        body: SingleChildScrollView(
          child: Container(
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
                            color: Colors.lightGreen,
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
                        ProfileHeader(
                          model: model,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
