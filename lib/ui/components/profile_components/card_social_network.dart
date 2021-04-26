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
        height: socialNetworkModel == null ? null : 152,
        decoration: BoxDecoration(
            color: socialNetworkModel == null
                ? Colors.transparent
                : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            socialNetworkModel == null
                ? Text("Usuário sem redes sociais")
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
                                      height: 75,
                                      width: 75,
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                              socialNetworkModel.twitter != null
                                  ? Image.network(
                                      snapshot.data['twitter'],
                                      height: 90,
                                      width: 90,
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                              socialNetworkModel.instagram != null
                                  ? Image.network(
                                      snapshot.data['instagram'],
                                      height: 90,
                                      width: 90,
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                            ],
                          ),
                        );
                      } else {
                        return Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      }
                    })
          ],
        ),
      ),
    );
  }
}
