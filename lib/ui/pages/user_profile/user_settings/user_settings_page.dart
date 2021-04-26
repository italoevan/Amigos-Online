import 'package:amigos_online/controller/user_profile_controllers/user_settings_controller/user_settings_controller.dart';
import 'package:amigos_online/ui/components/profile_components/profile_settings_components/settings_item.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSettings extends StatelessWidget {
  final UserSettingsController userSettingsController =
      Get.find<UserSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurações".toUpperCase(),
          style: TextStyle(fontFamily: 'Quantum'),
        ),
      ),
      body: Obx(
        () => LoadingUtil(
          loading: userSettingsController.isLoading.value,
          widget: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  SettingsItem(
                    icon: Icon(Icons.supervisor_account_sharp),
                    title: "Redes Sociais",
                    onTap: () =>
                        userSettingsController.showSocialNetworkDialog(context),
                  ),
                  SettingsItem(
                    icon: Icon(Icons.camera_alt),
                    title: "Mudar foto",
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icon(
                      Icons.color_lens,
                      color: Colors.red,
                    ),
                    title: "Mudar cor do perfil",
                    onTap: () {},
                  )
                ],
              )),
        ),
      ),
    );
  }
}
