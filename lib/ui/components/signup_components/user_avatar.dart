import 'package:amigos_online/utils/consts/consts_url.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child:Container(
                height: 140,
                width: 140,
                child: Image.network(ConstsUrl.avatarImage)),
    );
  }
}
