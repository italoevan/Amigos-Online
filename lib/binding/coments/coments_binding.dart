import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:get/get.dart';

class ComentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComentsController>(() => ComentsController());
  }
}
