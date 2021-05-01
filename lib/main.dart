import 'package:amigos_online/routes/app_pages.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/theme/app_theme.dart';
import 'package:amigos_online/utils/dart_notification/register_channel.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RegisterChannel.dartNotificationRegister();

  runApp(GetMaterialApp(
    initialRoute: Routes.INITIAL,
    getPages: AppPages.pages,
    defaultTransition: Transition.cupertino,
    theme: AppTheme.dark,
  ));
}
