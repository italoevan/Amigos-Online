import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/generic_components/generic_button.dart';
import 'package:amigos_online/ui/components/home_components/body/generic_action_button.dart';
import 'package:amigos_online/ui/components/home_components/body/new_post_button.dart';
import 'package:amigos_online/ui/components/home_components/drawer/drawer_home.dart';
import 'package:amigos_online/ui/components/home_components/body/home_posts_area.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:amigos_online/ui/components/home_components/body/new_post_area.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                controller.newPostIsOpen.value
                    ? Padding(
                        padding: EdgeInsets.all(24),
                        child: NewPostArea(
                          userController: userController,
                          controller: controller,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GenericActionButton(title: "Posts quentes", onTap: (){}),
                            NewPostButton(
                                onTap: () =>
                                    controller.newPostIsOpen.value = true),
                                     GenericActionButton(title: "CATEGORIAS", onTap: (){}),
                          ],
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
