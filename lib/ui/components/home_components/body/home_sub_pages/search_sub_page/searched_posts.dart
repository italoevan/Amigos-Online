import 'package:amigos_online/controller/home_controllers/sub_pages/search_controller.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/following_sub_page/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchedPosts extends StatelessWidget {
  SearchedPosts({@required this.searchController});
  final SearchController searchController;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: searchController.postsModel.length == 0
              ? EmptyPage()
              : searchController.postsModel.length == 0
                  ? EmptyPage()
                  : ListView.builder(
                      itemCount: searchController.postsModel.length,
                      itemBuilder: (context, index) {
                        return PostsItem(
                            model: searchController.postsModel[index]);
                      }),
        ));
  }
}
