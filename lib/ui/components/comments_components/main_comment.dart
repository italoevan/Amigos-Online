import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/comments_components/new_comment_area.dart';
import 'package:amigos_online/ui/components/comments_components/others_comments.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:amigos_online/utils/generic_utils/timestamp_to_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainComent extends StatelessWidget {
  final ComentsController controller;
  MainComent({
    @required this.model,
    @required this.controller,
    @required this.newPostController,
    @required this.userProviderController,
  });
  final PostsModel model;

  final TextEditingController newPostController;
  final UserProviderController userProviderController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Card(
          shadowColor: Colors.green,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Container(
            padding: EdgeInsets.only(top: 12, right: 12, left: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              UserModel userModel = UserModel();
                              var map = model.toJson();
                              userModel = UserModel.fromJson(map);

                              Get.toNamed(Routes.USERPROFILE, arguments: {
                                "isOwnProfile": false,
                                "userModel": userModel
                              });
                            },
                            child: Row(children: [
                              FutureBuilder(
                                  future: controller.getMainUserImage(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return MiniUserAvatar(
                                        hasNetworkImage: true,
                                        networkImage: snapshot.data,
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                              SizedBox(
                                width: 8,
                              ),
                              Text(model.user_name)
                            ]),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      height: 30,
                                      child: Text(model.tag),
                                    ),
                                    Divider(),
                                    Text(TimeStampToDate.convert(model.date))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Text(model.content),
                    ],
                  ),
                ),
                Divider(),
                OthersComments(
                  model: model,
                  controller: controller,
                ),
                NewCommentArea(
                  comentsController: controller,
                  newPostController: newPostController,
                  userProviderController: userProviderController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
