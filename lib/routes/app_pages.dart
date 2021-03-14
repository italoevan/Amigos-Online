import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/pages/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page:()=> SplashScreen())

  ];


}

