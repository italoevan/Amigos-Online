
import 'package:amigos_online/data/models/user_colors_model.dart';
import 'package:amigos_online/ui/pages/user_profile/user_settings/color_choose/color_choose_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorGrid extends StatelessWidget {
  final Function(String) onTap;
  final GridColorsModel model;
  ColorGrid({@required this.onTap, @required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(icon: Icon(Icons.close), onPressed: Get.back)),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.withOpacity(0.3),
          ),
          width: Get.width * 0.8,
          height: Get.height / 2,
          child: Flexible(
            child: GridView.builder(
                itemCount: model.colors.listColors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return ColorChooseItem(
                    model: model,
                    index: index,
                    onTap: (v) => onTap(v),
                  );
                }),
          ),
        ),
      ],
    ));
  }
}
