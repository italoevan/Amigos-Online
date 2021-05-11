import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/data/models/coments_posts_model.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/ui/components/home_components/body/mini_user_avatar.dart';
import 'package:amigos_online/utils/generic_utils/timestamp_to_date.dart';
import 'package:flutter/material.dart';

class ComentsItem extends StatelessWidget {
  ComentsItem(
      {@required this.model,
      @required this.index,
      @required this.length,
      @required this.controller});

  final ComentsPostsModel model;
  final ComentsController controller;
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
              GestureDetector(
                onTap: () async => controller
                    .getUserInformationToOpenProfile(model), //Open profile
                child: Row(
                  children: [
                    FutureBuilder(
                        future: controller.getOtherUsersImage(model),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return MiniUserAvatar(
                              networkImage: snapshot.data,
                              hasNetworkImage: true,
                            );
                          } else {
                            return SizedBox(
                                height: 45,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        }),
                    VerticalDivider(),
                    Text(model.user_name)
                  ],
                ),
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(TimeStampToDate.convert(model.date))))
            ],
          ),
          Divider(color: Colors.transparent),
          Text(model.content),
          length == index + 1
              ? Divider()
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }
}
