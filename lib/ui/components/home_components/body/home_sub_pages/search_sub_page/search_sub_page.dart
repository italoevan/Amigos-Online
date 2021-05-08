import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/controller/home_controllers/sub_pages/search_controller.dart';
import 'package:amigos_online/ui/components/generic_components/text_field_generic.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/search_sub_page/searched_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  Search(HomeController homeController) : this.homeController = homeController;
  final SearchController searchController = Get.put(SearchController());
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GenericTextField(
              onChanged: searchController.getSearchedPosts,
              controller: searchController.textEditingController,
            ),
          ),
          SearchedPosts(
            homeController: homeController,
            searchController: searchController,
          )
        ],
      ),
    );
  }
}
