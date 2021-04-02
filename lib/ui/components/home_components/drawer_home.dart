import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({@required this.controller});

  final UserProviderController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              controller.auth.signOut();
              Get.offAllNamed(Routes.CADASTRO);
            }),
      ),
    );
  }
}
