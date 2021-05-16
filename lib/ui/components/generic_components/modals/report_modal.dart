import 'package:amigos_online/ui/components/generic_components/generic_button.dart';
import 'package:amigos_online/ui/components/generic_components/text_field_generic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportModal extends StatelessWidget {
  ReportModal(this.textEditingController, {@required this.onPressed});
  final TextEditingController textEditingController;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height * 0.35,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.7),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Descreva o problema abaixo.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          Divider(color: Colors.transparent),
          GenericTextField(controller: textEditingController),
          Divider(color: Colors.transparent),
          GenericButton(
            onPressed: onPressed,
            title: 'Enviar',
            buttonColor: Colors.red,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
