import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/repository/other_comments_repository/other_comments_repository.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComentsController extends GetxController {
  PostsModel model;
  ComentsController({@required this.repository});
  final OtherCommentsRepository repository;

  @override
  void onInit() {
    model = Get.arguments["posts_model"];
    super.onInit();
  }

  Future getOthersUsersPost() async {}
}
