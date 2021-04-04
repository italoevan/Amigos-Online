import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/ui/components/profile_components/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomePostsArea extends StatelessWidget {
  HomePostsArea({@required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: controller.hasPostsLoaded.value
              ? ListView.builder(
                  itemCount: controller.listPosts.length,
                  itemBuilder: (context, index) {
                    return PostsItem(model: controller.listPosts[index]);
                  })
              : Center(
                  child: SpinKitHourGlass(
                    color: Colors.green,
                  ),
                ),
        ));
  }
}
