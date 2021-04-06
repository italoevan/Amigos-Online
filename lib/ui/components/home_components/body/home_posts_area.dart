import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomePostsArea extends StatelessWidget {
  HomePostsArea({@required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.hasPostsLoaded.value
        ? Expanded(
            child: ListView.builder(
                itemCount: controller.listPosts.length,
                itemBuilder: (context, index) {
                  return PostsItem(
                    model: controller.listPosts[index],
                    onNameTap: () async {
                      UserModel model = await controller
                          .getOtherUserInformation(controller.listPosts[index]);

                      Get.toNamed(Routes.USERPROFILE, arguments: {
                        "userModel": model,
                        "isOwnProfile": false
                      });
                    },
                  );
                }),
          )
        : Center(
            child: SpinKitHourGlass(
              color: Colors.green,
            ),
          ));
  }
}