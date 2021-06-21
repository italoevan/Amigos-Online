import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/models/report_model.dart';
import 'package:amigos_online/ui/components/generic_components/modals/report_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsItemController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  int comentsCount;

  @override
  void onInit() async {
    //Function here
    super.onInit();
  }



  Future<String> getImageFromUser(PostsModel model) async {
    var response =
        await firebaseFirestore.collection('users').doc(model.user_id).get();
    var value = response.data()['user_image'];

    return value;
  }

  Future<Map<String, dynamic>> userIsVip(PostsModel model) async {
    Map<String, dynamic> map = {'isVip ': false};

    try {
      var response =
          await firebaseFirestore.collection('users').doc(model.user_id).get();
      if (response.data()['customizedProfile'] != null &&
          response.data()['customizedProfile'] == true) {
        map = {'isVip': true, 'model': model};
        return map;
      }
      return map;
    } catch (e) {
      return map;
    }
  }

  report(PostsModel model) async {
    var atualDate = Timestamp.now().toString();
    TextEditingController controller = TextEditingController();
    showModalBottomSheet(
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        context: Get.context,
        builder: (BuildContext context) {
          return ReportModal(
            controller,
            onPressed: () async {
              if (controller.text != null && controller.text.isNotEmpty) {
                ReportModel reportModel = ReportModel();
                reportModel.description = controller.text;
                reportModel.postsModel = model;

                var jsonReport = reportModel.toJson();
                await firebaseFirestore
                    .collection('reports')
                    .doc(atualDate)
                    .set(jsonReport);
                Get.back();
                Get.snackbar('Sucesso!', 'Obrigado por enviar sua denúncia.');
              } else {
                Get.snackbar('Atenção', 'Não deixe o campo em branco.');
              }
            },
          );
        });
  }

  Future<String> getNumberOfComents(PostsModel model) async {
    try {
      var response = await firebaseFirestore
          .collection('users')
          .doc(model.user_id)
          .collection('posts')
          .doc(model.uid)
          .collection('coments')
          .get();
      int _comentsCount = 0;
      response.docs.forEach((element) {
        _comentsCount++;
      });

      return _comentsCount.toString();
    } catch (e) {
      return null;
    }
  }
}
