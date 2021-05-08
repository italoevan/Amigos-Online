import 'package:amigos_online/controller/home_controllers/sub_pages/hot_posts_controller.dart';
import 'package:amigos_online/data/models/user_model.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:amigos_online/utils/firebase_utils/get_atual_user_id.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotPosts extends StatelessWidget {
  final HotPostsController controller = Get.put(HotPostsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadingUtil(
          loading: controller.isLoading.value,
          widget: Container(
              width: Get.width,
              height: Get.height,
              child: controller.postsHasLoaded.value
                  ? SmartRefresher(
                      controller: controller.refreshController,
                      onRefresh: controller.refresh,
                      child: controller.listPostsModel.length == 0
                          ? Center(
                              child: SpinKitHourGlass(
                                color: Colors.green,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listPostsModel.length,
                              itemBuilder: (context, index) {
                                return PostsItem(
                                  index: index,
                                  lenght: controller.listPostsModel.length,
                                  model: controller.listPostsModel[index],
                                  onNameTap: () async {
                                    var atualUser =
                                        GetAtualUserId().getUserId();
                                    UserModel model = await controller
                                        .getOtherUserInformation(
                                            controller.listPostsModel[index]);

                                    if (atualUser == model.user_id) {
                                      Get.toNamed(Routes.USERPROFILE,
                                          arguments: {
                                            "userModel": model,
                                            "isOwnProfile": true
                                          });
                                    } else {
                                      Get.toNamed(Routes.USERPROFILE,
                                          arguments: {
                                            "userModel": model,
                                            "isOwnProfile": false
                                          });
                                    }
                                  },
                                );
                              }),
                    )
                  : Center(
                      child: SpinKitHourGlass(
                        color: Colors.green,
                      ),
                    )),
        ));
  }
}
