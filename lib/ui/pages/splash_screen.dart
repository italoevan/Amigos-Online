import 'package:amigos_online/controller/splash_controller.dart';
import 'package:amigos_online/ui/components/generic_components/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Logo()),
            SizedBox(
              height: 12,
            ),
            Image.asset(
              'assets/images/icon.png',
              height: 120,
              width: 120,
            )
          ],
        ),
      ),
    );
  }
}
