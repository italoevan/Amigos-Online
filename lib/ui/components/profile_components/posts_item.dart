import 'package:amigos_online/data/models/posts_model.dart';
import 'package:flutter/material.dart';

class PostsItem extends StatelessWidget {
  PostsItem({@required this.model});
  final PostsModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      child: Card(
        child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(model.content)],
            )),
      ),
    );
  }
}
