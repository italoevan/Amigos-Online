import 'package:amigos_online/controller/coments/coments_controller.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComentsView extends StatelessWidget {
 
  final ComentsController controller = Get.find<ComentsController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comentários")),
    );
  }
}
