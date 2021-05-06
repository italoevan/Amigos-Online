import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchItem extends StatelessWidget {
  SearchItem(this.homeController);

  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.atualPage.value == 1
        ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () => homeController.pageController.animateToPage(4,
                curve: Curves.elasticOut,
                duration: Duration(milliseconds: 300)))
        : SizedBox());
  }
}
