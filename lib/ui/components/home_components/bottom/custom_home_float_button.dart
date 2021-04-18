import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeFloatButton extends StatelessWidget {
  CustomHomeFloatButton({@required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.green,
      child: Obx(() => Icon(
            controller.atualPage.value == 1 ? Icons.add : Icons.home,
            color: controller.atualPage.value == 1 ? Colors.red : Colors.white,
          )),
      onPressed: () {
        controller.pageController.page.toInt() == 1
            ? controller.newPostIsOpen.value = true
            : controller.pageController.animateToPage(1,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInCirc);
      },
    );
  }
}
