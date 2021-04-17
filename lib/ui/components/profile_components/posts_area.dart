import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostsArea extends StatelessWidget {
  PostsArea({@required this.controller, this.isOwnProfile});
  final UserProfileController controller;
  bool isOwnProfile = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.hasPostsLoaded.value
        ? Expanded(
            child: controller.listPosts.length == 0
                ? Column(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/images/bad-review.png',
                          height: 140,
                          width: 140,
                        ),
                      ),
                      Divider(color: Colors.transparent),
                      Text("Nenhuma publicação ainda :( ")
                    ],
                  )
                : SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () async {
                      controller.hasPostsLoaded.value = false;
                      controller.hasPostsLoaded.value =
                          await controller.getUserPosts();
                      controller.refreshController.refreshCompleted();
                      return;
                    },
                    child: ListView.builder(
                        itemCount: controller.listPosts.length,
                        itemBuilder: (context, index) {
                          return PostsItem(model: controller.listPosts[index]);
                        }),
                  ),
          )
        : Center(
            child: SpinKitHourGlass(
              color: Colors.green,
            ),
          ));
  }
}
