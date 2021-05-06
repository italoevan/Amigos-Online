import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/providers/user_provider.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/following_sub_page/following_sub_page.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/hot_posts_sub_page/hot_posts_sub_page.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/search_sub_page/search_sub_page.dart';
import 'package:amigos_online/ui/components/home_components/body/search_item.dart';
import 'package:amigos_online/ui/components/home_components/bottom/custom_bottom_navigation_bar.dart';
import 'package:amigos_online/ui/components/home_components/bottom/custom_home_float_button.dart';
import 'package:amigos_online/ui/components/home_components/drawer/drawer_home.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/home_posts_subpage/home_posts_area.dart';
import 'package:amigos_online/utils/generic_utils/loading_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final UserProviderController userController =
      Get.find<UserProviderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      drawer: HomeDrawer(
        homeController: controller,
        controller: userController,
      ),
      appBar: AppBar(
        title: Obx(() => Text(
              controller.defineAtualPage(),
              style: TextStyle(fontFamily: 'Quantum'),
            )),
        actions: [SearchItem(controller)],
      ),
      body: Obx(() => LoadingUtil(
          widget: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    children: [
                      HotPosts(),
                      HomePostsArea(controller: controller),
                      Following(),
                      Search(controller)
                    ],
                  ),
                )
              ],
            ),
          ),
          loading: controller.isLoading.value)),
      floatingActionButton: CustomHomeFloatButton(
        controller: controller,
        userController: userController,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigation(
        controller: controller,
      ),
    );
  }
}
