import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/generic_components/user_avatar.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:amigos_online/ui/components/home_components/drawer/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({@required this.controller, @required this.homeController});
  final HomeController homeController;
  final UserProviderController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  homeController.isLoading.value = true;
                  Get.back();
                  await controller.getUserInformations();
                  homeController.isLoading.value = false;
                  Get.toNamed(Routes.USERPROFILE, arguments: {
                    "userModel": controller.userModel,
                    "isOwnProfile": true
                  });
                },
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: UserAvatar(
                        isNetworkImage: true,
                        networkImage: controller.userModel.user_image),
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
              DrawerItem(
                title: 'Nos avalie',
                icon: Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                onTap: () {},
              ),
              DrawerItem(title: 'Seu Perfil',
              icon: Icon(Icons.person, color: Colors.green,),
              onTap: (){},
              ),
              DrawerItem(
                title: 'Sair',
                icon: Icon(Icons.logout, color: Colors.red,),
                onTap: () {
                  controller.auth.signOut();
                  Get.offAllNamed(Routes.LOGIN);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
