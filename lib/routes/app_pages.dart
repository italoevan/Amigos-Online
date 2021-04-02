import 'package:amigos_online/binding/cadastro_binding/cadastro_binding.dart';
import 'package:amigos_online/binding/home_binding/home_binding.dart';
import 'package:amigos_online/binding/home_binding/user_provider_binding.dart';
import 'package:amigos_online/routes/app_routes.dart';
import 'package:amigos_online/ui/pages/home/home_view.dart';
import 'package:amigos_online/ui/pages/login_cadastro/cadastro_view.dart';
import 'package:amigos_online/ui/pages/login_cadastro/login_view.dart';
import 'package:amigos_online/ui/pages/splash_screen.dart';
import 'package:amigos_online/ui/pages/user_profile/user_profile_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => SplashScreen()),
    GetPage(name: Routes.HOME, page: () => HomeView(), bindings:[ HomeBinding(),UserProviderBinding()]),
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(
        name: Routes.CADASTRO,
        page: () => CadastroView(),
        bindings: [CadastroBinding()]),
        GetPage(name: Routes.USERPROFILE, page: ()=> UserProfileView())
  ];
}
