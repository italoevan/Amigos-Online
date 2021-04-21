import 'package:amigos_online/controller/home_controllers/sub_pages/following_controller.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Following extends StatelessWidget {
  final FollowingController controller = Get.put(FollowingController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadingUtil(
          loading: controller.isLoading.value,
          widget: Container(
              height: Get.height,
              width: Get.width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: controller.postsHasLoaded.value == null
                  ? Text("Voce nao segue nd")
                  : controller.postsHasLoaded.value
                      ? Expanded(
                          child: SmartRefresher(
                            controller: controller.refreshController,
                            onRefresh: controller.onRefresh,
                            child: ListView.builder(
                                itemCount: controller.listPosts.length,
                                itemBuilder: (context, index) {
                                  return PostsItem(
                                      model: controller.listPosts[index]);
                                }),
                          ),
                        )
                      : Center(
                          child:SpinKitHourGlass(color: Colors.green,),
                        )),
        ));
  }
}
