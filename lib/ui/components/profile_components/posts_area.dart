import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class PostsArea extends StatelessWidget {
  PostsArea({@required this.controller,});
  final UserProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.hasPostsLoaded.value
        ? Expanded(
            child: ListView.builder(
                itemCount: controller.listPosts.length,
                itemBuilder: (context, index) {
                  return PostsItem(model: controller.listPosts[index]);
                }),
          )
        : Center(
            child: SpinKitHourGlass(
              color: Colors.green,
            ),
          ));
  }
}
