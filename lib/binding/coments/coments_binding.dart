import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/data/provider/others_coments_provider/other_comments_provider.dart';
import 'package:amigos_online/data/repository/other_comments_repository/other_comments_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ComentsBinding implements Bindings {
  @override
  void dependencies() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OtherComentsProvider provider =
        OtherComentsProvider(firestore: firebaseFirestore);
    OtherCommentsRepository repository =
        OtherCommentsRepository(provider: provider);

    Get.lazyPut<ComentsController>(
        () => ComentsController(repository: repository));
  }
}
