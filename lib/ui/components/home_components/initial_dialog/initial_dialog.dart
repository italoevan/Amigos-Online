import 'package:amigos_online/data/models/initial_dialog_moddel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialDialogView extends StatelessWidget {
  final InitialDialogModel model;

  InitialDialogView(this.model);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(12)),
        child: Stack(children: [
          Positioned(
            left: 0,
            top: 0,
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close)),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.dialogModel.title,
                  style: TextStyle(fontFamily: 'Quantum', fontSize: 20),
                ),
                Divider(),
                model.dialogModel.hasImage
                    ? Image.network(
                        model.dialogModel.linkImage,
                        width: Get.width,
                        height: 200,
                      )
                    : SizedBox(),
                Text(
                  model.dialogModel.content,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
