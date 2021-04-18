import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigation extends StatelessWidget {
  CustomBottomNavigation({@required this.controller});

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.green,
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(() => IconButton(
                icon: Icon(
                  Icons.local_fire_department_rounded,
                  color: controller.atualPage.value == 0
                      ? Colors.red
                      : Colors.white,
                  size: controller.atualPage.value == 0 ? 32 : 24,
                ),
                onPressed: () => controller.pageController.animateToPage(0,
                    curve: Curves.easeInCirc,
                    duration: Duration(milliseconds: 300)))),
            Obx(() => IconButton(
                icon: Icon(
                  Icons.list_alt,
                  color: controller.atualPage.value == 2
                      ? Colors.red
                      : Colors.white,
                  size: controller.atualPage.value == 2 ? 32 : 24,
                ),
                onPressed: () => controller.pageController.animateToPage(2,
                    curve: Curves.easeInCirc,
                    duration: Duration(milliseconds: 300))))
          ],
        ),
      ),
    );
  }
}
