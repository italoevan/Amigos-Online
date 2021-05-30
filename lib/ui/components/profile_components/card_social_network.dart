import 'package:amigos_online/controller/user_profile_controllers/user_profile_controller.dart';
import 'package:amigos_online/utils/generic_utils/social_network_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardSocialNetwork extends StatefulWidget {
  CardSocialNetwork(this.socialNetworkModel, this.profileController);
  final UserProfileController profileController;
  final dynamic socialNetworkModel;

  @override
  _CardSocialNetworkState createState() => _CardSocialNetworkState();
}

class _CardSocialNetworkState extends State<CardSocialNetwork> {
  double containerHeight = 150;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: widget.socialNetworkModel == null ? null : 152,
        decoration: BoxDecoration(
            color: widget.socialNetworkModel == null
                ? Colors.transparent
                : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.socialNetworkModel == null
                ? Text("Usuário sem redes sociais")
                : FutureBuilder(
                    future: SocialNetworkProvider.getImages(),
                    builder:
                        (_, AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: containerHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              !verifyAllIsNull([
                                widget.socialNetworkModel.whatsapp,
                                widget.socialNetworkModel.twitter,
                                widget.socialNetworkModel.instagram
                              ])
                                  ? widget.socialNetworkModel.whatsapp != null
                                      ? GestureDetector(
                                          onTap: () => widget.profileController
                                              .openUrlSocialNetwork(
                                                  socialNetork: 'whatsapp',
                                                  url: widget.socialNetworkModel
                                                      .whatsapp
                                                      .toString()),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        blurRadius: 11)
                                                  ]),
                                              child: Image.network(
                                                snapshot.data['whatsapp'],
                                                height: 75,
                                                width: 75,
                                              )),
                                        )
                                      : SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                  : Text("Usuário sem redes sociais"),
                              widget.socialNetworkModel.twitter != null &&
                                      widget.socialNetworkModel.twitter != ""
                                  ? GestureDetector(
                                      onTap: () => widget.profileController
                                          .openUrlSocialNetwork(
                                              socialNetork: 'twitter',
                                              url: GetUtils.isURL(
                                                      widget.socialNetworkModel
                                                          .twitter)
                                                  ? widget.socialNetworkModel.twitter
                                                  : 'http://twitter.com/${widget.socialNetworkModel.twitter}'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  blurRadius: 8)
                                            ]),
                                        child: Image.network(
                                          snapshot.data['twitter'],
                                          height: 90,
                                          width: 90,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                              widget.socialNetworkModel.instagram != null &&
                                      widget.socialNetworkModel.instagram != ""
                                  ? GestureDetector(
                                      onTap: () => widget.profileController
                                          .openUrlSocialNetwork(
                                              socialNetork: 'instagram',
                                              url: GetUtils.isURL(
                                                      widget.socialNetworkModel
                                                          .instagram)
                                                  ? widget.socialNetworkModel.instagram
                                                  : 'http://instagram.com/${widget.socialNetworkModel.instagram}'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  blurRadius: 8)
                                            ]),
                                        child: Image.network(
                                          snapshot.data['instagram'],
                                          height: 90,
                                          width: 90,
                                        ),
                                      ),
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

  bool verifyAllIsNull(List<dynamic> list) {
    int count = 0;
    list.forEach((element) {
      if (element == null ) {
        DoNothingAction();
      } else {
        count++;
      }
    });

    if (count != 0) {
      return false;
    }
    
    return true;
  }
}
