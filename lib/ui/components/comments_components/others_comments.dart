import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/ui/components/comments_components/other_comments_item.dart';
import 'package:flutter/material.dart';

class OthersComments extends StatelessWidget {
  OthersComments({@required this.model, @required this.controller});
  final PostsModel model;
  final ComentsController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return OtherCommentsItem();
      },
    );
  }
}
