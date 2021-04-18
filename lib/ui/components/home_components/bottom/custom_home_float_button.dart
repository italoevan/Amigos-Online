import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/ui/components/home_components/body/new_post_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeFloatButton extends StatelessWidget {
  CustomHomeFloatButton(
      {@required this.controller, @required this.userController});
  final HomeController controller;
  final UserProviderController userController;

  GlobalKey globalKey = GlobalKey();

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
            ? Get.dialog(
                AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                    contentPadding: EdgeInsets.all(0),
                    content: StatefulBuilder(
                      builder: (context, builder) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: NewPostArea(
                                  key: globalKey,
                                  controller: controller,
                                  userController: userController),
                            ),
                          ],
                        );
                      },
                    )),
              )
            //controller.newPostIsOpen.value = true
            : controller.pageController.animateToPage(1,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInCirc);
      },
    );
  }
}
