import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/ui/components/comments_components/NavigationBarItem.dart';
import 'package:amigos_online/ui/components/comments_components/main_comment.dart';
import 'package:amigos_online/ui/components/comments_components/others_comments.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComentsView extends StatefulWidget {
  @override
  _ComentsViewState createState() => _ComentsViewState();
}

class _ComentsViewState extends State<ComentsView> {
  final ComentsController controller = Get.find<ComentsController>();

  UserProviderController userProviderController;

  @override
  void initState() {
    userProviderController = controller.userProviderController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comentários")),
      body: Obx(() => LoadingUtil(
          loading: controller.isLoading.value,
          widget: Container(
            padding: EdgeInsets.all(32),
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainComent(
                  userProviderController: userProviderController,
                  model: controller.model,
                  controller: controller,
                  newPostController: controller.newPostController,
                ),
              ],
            ),
          ))),
      bottomNavigationBar: NavigationBarItem(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() => FloatingActionButton(
            backgroundColor:
                controller.isLoading.value ? Colors.grey[600] : Colors.green,
            child: Icon(
              Icons.add,
            ),
            onPressed: () => controller.isLoading.value
                ? null
                : controller.newComments(context),
          )),
    );
  }
}
