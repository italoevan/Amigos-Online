import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/ui/components/comments_components/others_comments.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainComent extends StatelessWidget {
  final ComentsController controller;
  MainComent({@required this.model, @required this.controller});
  final PostsModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Container(
        padding: EdgeInsets.only(top: 12, right: 12, left: 12),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Row(children: [
                  MiniUserAvatar(
                    hasNetworkImage: true,
                    networkImage: model.user_image,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(model.user_name)
                ]),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16)),
                        height: 30,
                        child: Text(model.tag),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Text(model.content),
            Divider(),
            OthersComments(
              controller: controller,
              model: model,
            )
          ],
        ),
      ),
    );
  }
}
