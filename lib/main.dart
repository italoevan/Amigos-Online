import 'package:amigos_online/routes/app_pages.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(GetMaterialApp(
    initialRoute: Routes.INITIAL,
    getPages: AppPages.pages,
    defaultTransition: Transition.cupertino,
  ));
}
