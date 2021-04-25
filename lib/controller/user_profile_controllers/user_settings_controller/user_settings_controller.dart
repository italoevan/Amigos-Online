import 'package:amigos_online/utils/generic_utils/social_network_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSettingsController extends GetxController {
  showSocialNetworkDialog(BuildContext context) async {
    TextEditingController _twitterController = TextEditingController(text: "Vrau");
    Map<String, dynamic> imageLink = await SocialNetworkProvider.getImages();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(12),
            color: Colors.green,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.network(
                      imageLink['whatsapp'],
                      height: 70,
                      width: 70,
                    ),
                    Flexible(child: TextField(controller: _twitterController,))
                  ],
                )
              ],
            ),
          );
        });
  }
}
