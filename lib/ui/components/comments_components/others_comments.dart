import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/ui/components/comments_components/comments_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class OthersComments extends StatelessWidget {
  OthersComments({@required this.model, @required this.controller});
  final PostsModel model;
  final ComentsController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.otherComentshasLoaded.value
        ? controller.list.length == 0
            ? controller.isLoading.value
                ? Expanded(child: Container())
                : Expanded(
                    child: Container(
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/bad-review.png',
                              height: 70,
                              width: 70,
                            ),
                            Text(
                              "Sem comentários ainda  :( ",
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ),
                  ))
            : Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    return ComentsItem(
                      controller: controller,
                      model: controller.list[index],
                      index: index,
                      length: controller.list.length,
                    );
                  },
                ),
              )
        : Expanded(
            child: Container(
                child: Center(
            child: SpinKitHourGlass(
              color: Colors.green,
            ),
          ))));
  }
}
