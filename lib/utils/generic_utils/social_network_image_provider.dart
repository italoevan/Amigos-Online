import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SocialNetworkProvider {
  static Future<Map<String, dynamic>> getImages() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> mapImages = Map();

    var response =
        await firestore.collection('social_network_images').doc('images').get();

    mapImages = response.data();
    return mapImages;
  }
}
