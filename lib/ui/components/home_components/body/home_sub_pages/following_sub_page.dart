import 'package:amigos_online/controller/home_controllers/sub_pages/following_controller.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Following extends StatelessWidget {
  final FollowingController controller = Get.put(FollowingController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        height: Get.height,
        width: Get.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: controller.postsHasLoaded.value == null
            ? Text("Voce nao segue nd")
            : controller.postsHasLoaded.value
                ? Expanded(
                    child: ListView.builder(
                        itemCount: controller.listPosts.length,
                        itemBuilder: (context, index) {
                          return PostsItem(model: controller.listPosts[index]);
                        }),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
