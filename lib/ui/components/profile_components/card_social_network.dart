import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/data/models/social_network_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardSocialNetwork extends StatelessWidget {
  CardSocialNetwork(this.socialNetworkModel, this.profileController);
  final UserProfileController profileController;
  final dynamic socialNetworkModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(16)),
        child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                socialNetworkModel == null
                    ? Text("User sem redes sociais")
                    : Text("User com redes sociais")
              ],
            ),
      ),
    );
  }
}
