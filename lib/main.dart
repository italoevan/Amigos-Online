import 'package:amigos_online/routes/app_pages.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/theme/app_theme.dart';
import 'package:amigos_online/utils/dart_notification/register_channel.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RegisterChannel.dartNotificationRegister();

  //Remove this method to stop OneSignal Debugging

  OneSignal.shared.init(
    "01c28a89-7e60-43e2-9cbd-602ccc49f561",
  );
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(GetMaterialApp(
    initialRoute: Routes.INITIAL,
    getPages: AppPages.pages,
    defaultTransition: Transition.cupertino,
    theme: AppTheme.dark,
  ));
}
