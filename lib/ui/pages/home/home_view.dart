import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/home_components/drawer_home.dart';
import 'package:amigos_online/ui/components/home_components/home_posts_area.dart';
import 'package:amigos_online/ui/components/home_components/mini_user_avatar.dart';
import 'package:amigos_online/ui/components/home_components/new_post_area.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final UserProviderController userController =
      Get.find<UserProviderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(
        controller: userController,
      ),
      appBar: AppBar(
        title: Text("Amigos Online"),
        actions: [
          MiniUserAvatar(
            controller: userController,
            onTap: () async {
              controller.isLoading.value = true;
              await userController.getUserInformations();
              controller.isLoading.value = false;
              Get.toNamed(Routes.USERPROFILE, arguments: {
                "userModel": userController.userModel,
                "isOwnProfile": true
              });
            },
          )
        ],
      ),
      body: Obx(() => LoadingUtil(
          widget: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: NewPostArea(
                    userController: userController,
                    controller: controller,
                  ),
                ),
                Divider(),
                HomePostsArea(
                  controller: controller,
                )
              ],
            ),
          ),
          loading: controller.isLoading.value)),
    );
  }
}
