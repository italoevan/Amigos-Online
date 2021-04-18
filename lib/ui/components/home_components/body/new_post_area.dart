import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/ui/components/generic_components/generic_button.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:amigos_online/ui/components/generic_components/text_field_generic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostArea extends StatefulWidget {
  NewPostArea(
      {Key key, @required this.controller, @required this.userController})
      : super(key: key);
  final HomeController controller;
  final UserProviderController userController;

  @override
  _NewPostAreaState createState() => _NewPostAreaState();
}

class _NewPostAreaState extends State<NewPostArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
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
                  Get.back();
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
                  children: [
                    Obx(() => InkWell(
                          onTap: widget.controller.openDialogToChooseTag,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(16)),
                            height: 30,
                            child: Text(
                                widget.controller.atualTagChoose.value == 0
                                    ? "Escolha a tag"
                                    : widget.controller.userChose.value
                                        .toString()),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: MiniUserAvatar(
                  controller: widget.userController,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Obx(() => GenericTextField(
                      error: widget.controller.newPostMessageError.value == ""
                          ? null
                          : widget.controller.newPostMessageError.value,
                      maxLength: 75,
                      controller: widget.controller.newPostController.value,
                    )),
              )),
            ],
          ),
          Divider(),
          Center(
            child: SizedBox(
              width: 110,
              child: Obx(() => GenericButton(
                  title: "Postar",
                  onPressed: widget.controller.isLoading.value == true
                      ? null
                      : () => widget.controller.newPost(context)
                  //widget.controller.newPost(context),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
