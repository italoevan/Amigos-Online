import 'package:amigos_online/data/models/coments_posts_model.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:flutter/material.dart';

class ComentsItem extends StatelessWidget {
  ComentsItem(
      {@required this.model, @required this.index, @required this.length});

  final ComentsPostsModel model;
  final int index;
  final int length;
  @override
  Widget build(BuildContext context) {

    
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index == 0
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : Divider(),
          Row(
            children: [
              MiniUserAvatar(
                networkImage: model.user_image,
                hasNetworkImage: true,
              ),
              VerticalDivider(),
              Text(model.user_name)
            ],
          ),
          Divider(color: Colors.transparent),
          Text(model.content),
          length == index+1
              ? Divider()
              : SizedBox(
                  width: 0,
                  height: 0,
                )
        ],
      ),
    );
  }
}