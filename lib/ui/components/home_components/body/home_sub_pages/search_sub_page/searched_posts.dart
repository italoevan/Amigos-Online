import 'package:amigos_online/controller/home_controllers/home_controller.dart';
import 'package:amigos_online/controller/home_controllers/sub_pages/search_controller.dart';
import 'package:amigos_online/ui/components/generic_components/posts_item.dart';
import 'package:amigos_online/ui/components/home_components/body/home_sub_pages/following_sub_page/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchedPosts extends StatefulWidget {
  SearchedPosts(
      {@required this.searchController, @required this.homeController});
  final HomeController homeController;
  final SearchController searchController;

  @override
  _SearchedPostsState createState() => _SearchedPostsState();
}

class _SearchedPostsState extends State<SearchedPosts> {
  @override
  void initState() {
    widget.homeController.atualPage.listen((a) {
      if (a != 4) {
        widget.searchController.postsModel.clear();
        widget.searchController.textEditingController.clear();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: widget.searchController.postsModel.length == 0
              ? EmptyPage(
                  message: 'Faça sua busca',
                )
              : widget.searchController.postsModel.length == 0
                  ? EmptyPage(
                      message: 'Faça sua busca',
                    )
                  : ListView.builder(
                    physics: BouncingScrollPhysics(),
                      itemCount: widget.searchController.postsModel.length,
                      itemBuilder: (context, index) {
                        return PostsItem(
                            index: index,
                            lenght: widget.searchController.postsModel.length,
                            model: widget.searchController.postsModel[index]);
                      }),
        ));
  }
}
