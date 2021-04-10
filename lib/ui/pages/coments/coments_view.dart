import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/ui/components/comments_components/NavigationBarItem.dart';
import 'package:amigos_online/ui/components/comments_components/main_comment.dart';
import 'package:amigos_online/ui/components/comments_components/others_comments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComentsView extends StatelessWidget {
  final ComentsController controller = Get.find<ComentsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comentários")),
      body: Container(
        padding: EdgeInsets.all(32),
        height: Get.height,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MainComent(
              model: controller.model,
              controller: controller,
              newPostController: controller.newPostController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarItem(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
