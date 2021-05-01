import 'package:amigos_online/controller/home_controllers/sub_pages/hot_posts_controller.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotPosts extends StatelessWidget {
  final HotPostsController controller = Get.put(HotPostsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.postsHasLoaded.value
        ? ListView.builder(
          itemCount: controller.listPostsModel.length,
          itemBuilder: (context, index) {
            return PostsItem(model: controller.listPostsModel[index]);
          })
        : Container());
  }
}
