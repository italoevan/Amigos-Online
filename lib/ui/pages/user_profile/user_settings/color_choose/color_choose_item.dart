import 'package:amigos_online/data/models/user_colors_model.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/utils/generic_utils/hex_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorChooseItem extends StatelessWidget {
  final int index;
  final GridColorsModel model;
  final Function(String) onTap;
  ColorChooseItem(
      {@required this.model, @required this.onTap, @required this.index});
  @override
  Widget build(BuildContext context) {
    var color = model.colors.listColors[index];

    return GestureDetector(
      onTap: () => onTap(model.colors.listColors[index].hex),
      child: Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: HexConverter.toColor(color.hex),
                    borderRadius: BorderRadius.circular(100))),
                    verifyIsSelected() ? Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.verified, color: Colors.green,)) : SizedBox()
          ],
        ),
      ),
    );
  }

  bool verifyIsSelected() {
    UserProviderController controller = Get.find<UserProviderController>();
    if (controller.userModel.hexColor == model.colors.listColors[index].hex) {
      return true;
    }
    return false;
  }
}
