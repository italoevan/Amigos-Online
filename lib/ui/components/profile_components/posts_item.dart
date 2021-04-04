import 'package:amigos_online/controller/posts_item_controller/posts_item_controller.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/ui/components/signup_components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsItem extends StatelessWidget {
  PostsItem({@required this.model, this.onNameTap});
  final PostsModel model;
  final Function onNameTap;
  final PostsItemController controller = Get.put(PostsItemController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      child: Card(
          child: Container(
              padding: EdgeInsets.all(8),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onNameTap,
                          child: Row(
                            children: [
                              UserAvatar(
                                isNetworkImage: true,
                                isMiniAvatar: true,
                                networkImage: model.user_image,
                              ),
                              Text(model.user_name),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(" " + model.tag.toUpperCase()))
                          ],
                        ))
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(model.content),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: FutureBuilder(
                          future: controller.getNumberOfComents(model),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return FlatButton(
                                  onPressed: () {},
                                  child: Text("Comentar (${snapshot.data})"));
                            } else {
                              return FlatButton(
                                  onPressed: () {},
                                  child: Text("Comentar (0)"));
                            }
                          },
                        )),
                        Expanded(
                            child: FlatButton(
                                onPressed: () {}, child: Text("Denunciar"))),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
