import 'package:amigos_online/data/models/posts_model.dart';
import 'package:get/get.dart';

class ComentsController extends GetxController {
  final PostsModel model = Get.arguments["posts_model"];
}
