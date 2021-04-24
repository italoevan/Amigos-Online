import 'package:cloud_firestore/cloud_firestore.dart';

class SocialNetworkProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, String>> getImages() async {
    Map<String, dynamic> mapImages = Map();

    var response =
        await firestore.collection('social_network_images').doc('images').get();

    mapImages = response.data();
    return mapImages;
  }
}
