import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/home_components/drawer_home.dart';
import 'package:amigos_online/ui/components/home_components/mini_user_avatar.dart';
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
    return Provider<UserProviderController>(
      create: (_) => userController,
      child: Scaffold(
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
                Get.toNamed(Routes.USERPROFILE,
                    arguments: {"userModel": userController.userModel});
              },
            )
          ],
        ),
        body: Obx(() => LoadingUtil(
            widget: Container(), loading: controller.isLoading.value)),
      ),
    );
  }
}
