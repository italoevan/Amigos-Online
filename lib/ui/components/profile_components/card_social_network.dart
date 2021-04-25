import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/utils/generic_utils/social_network_image_provider.dart';
import 'package:flutter/material.dart';


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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            socialNetworkModel == null
                ? Text("User sem redes sociais")
                : FutureBuilder(
                    future: SocialNetworkProvider.getImages(),
                    builder:
                        (_, AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              socialNetworkModel.whatsapp != null
                                  ? Image.network(
                                      snapshot.data['whatsapp'],
                                      height: 90,
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                            ],
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
          ],
        ),
      ),
    );
  }
}
