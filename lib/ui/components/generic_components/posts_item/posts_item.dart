import 'package:amigos_online/controller/posts_item_controller/posts_item_controller.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item/vip_icon.dart';
import 'package:amigos_online/ui/components/generic_components/user_avatar.dart';
import 'package:amigos_online/utils/generic_utils/hex_converter.dart';
import 'package:amigos_online/utils/generic_utils/timestamp_to_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsItem extends StatelessWidget {
  PostsItem({@required this.model, this.onNameTap, this.lenght, this.index});
  final PostsModel model;
  final Function onNameTap;
  final int index;
  final int lenght;

  final PostsItemController controller = Get.put(PostsItemController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: lenght != null && index != null
          ? lenght == index + 1
              ? EdgeInsets.only(left: 12, right: 12, bottom: 80)
              : EdgeInsets.only(left: 12, right: 12)
          : EdgeInsets.only(left: 12, right: 12),
      child: Stack(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
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
                                  FutureBuilder(
                                      future:
                                          controller.getImageFromUser(model),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return UserAvatar(
                                            isNetworkImage: true,
                                            isMiniAvatar: true,
                                            networkImage: snapshot.data,
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(model.user_name),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                            " " + model.tag.toUpperCase())),
                                    Divider(),
                                    Text(TimeStampToDate.convert(model.date))
                                  ],
                                ),
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
                                      onPressed: () {
                                        Get.toNamed(Routes.COMENTS, arguments: {
                                          "posts_model": model,
                                        });
                                      },
                                      child:
                                          Text("Comentar (${snapshot.data})"));
                                } else {
                                  return FlatButton(
                                      onPressed: () {},
                                      child: Text("Comentar (0)"));
                                }
                              },
                            )),
                            Expanded(
                                child: FlatButton(
                                    onPressed: () => controller.report(model),
                                    child: Text("Denunciar"))),
                          ],
                        )
                      ],
                    ),
                  ))),
          FutureBuilder(
              future: controller.userIsVip(model),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['isVip'] != null &&
                      snapshot.data['isVip'] == true) {
                    return Positioned(bottom: 10, right: 0, child: VipIcon());
                  }

                  return SizedBox();
                } else {
                  return SizedBox();
                }
              })
        ],
      ),
    );
  }
}
