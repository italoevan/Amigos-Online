import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/home_components/body/generic_action_button.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/categories_sub_page.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/hot_posts_sub_page.dart';
import 'package:amigos_online/ui/components/home_components/body/new_post_button.dart';
import 'package:amigos_online/ui/components/home_components/drawer/drawer_home.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/home_posts_area.dart';
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
        title: Text(
          "Amigos Online",
          style: TextStyle(fontFamily: 'Quantum'),
        ),
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
                            GenericActionButton(
                                hasIcon: true,
                                primaryColor: Colors.green,
                                icon: Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.red,
                                ),
                                title: "POSTS ATIVOS",
                                onTap: () => controller.pageController
                                    .animateToPage(0,
                                        curve: Curves.easeInCirc,
                                        duration: Duration(milliseconds: 300))),
                            NewPostButton(
                                controller: controller,
                                onTap: () {
                                  controller.pageController.page.toInt() == 1
                                      ? controller.newPostIsOpen.value = true
                                      : controller.pageController.animateToPage(
                                          1,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInCirc);
                                }),
                            GenericActionButton(
                                title: "CATEGORIAS",
                                primaryColor: Colors.green,
                                onTap: () => controller.pageController
                                    .animateToPage(2,
                                        curve: Curves.easeInCirc,
                                        duration: Duration(milliseconds: 300))),
                          ],
                        ),
                      ),
                Divider(),
                Flexible(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    children: [
                      HotPosts(),
                      HomePostsArea(controller: controller),
                      Categories()
                    ],
                  ),
                )
              ],
            ),
          ),
          loading: controller.isLoading.value)),
    );
  }
}
