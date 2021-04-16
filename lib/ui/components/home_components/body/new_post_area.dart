import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:amigos_online/ui/components/generic_components/text_field_generic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostArea extends StatelessWidget {
  NewPostArea({@required this.controller, @required this.userController});
  final HomeController controller;
  final UserProviderController userController;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              
              children: [
                GestureDetector(
                      onTap: () {
                        controller.newPostIsOpen.value = false;
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(Icons.close),
                      ),
                    ),
                Expanded(
                                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ Obx(() => InkWell(
                        onTap: controller.openDialogToChooseTag,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16)),
                          height: 30,
                          child: Text(controller.atualTagChoose.value == 0
                              ? "Escolha a tag"
                              : controller.userChose.value.toString()),
                        ),
                      ))],),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: MiniUserAvatar(
                    controller: userController,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Obx(() => GenericTextField(
                        error: controller.newPostMessageError.value == ""
                            ? null
                            : controller.newPostMessageError.value,
                        maxLength: 75,
                        controller: controller.newPostController.value,
                      )),
                )),
              ],
            ),
            Divider(),
            Center(
              child: SizedBox(
                width: 110,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () => controller.newPost(context),
                  child: Text("Postar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
