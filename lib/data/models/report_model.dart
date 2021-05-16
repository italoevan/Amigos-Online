import 'package:amigos_online/data/models/posts_model.dart';

class ReportModel {
  PostsModel postsModel;
  String description;

  ReportModel();

  ReportModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    postsModel = PostsModel.fromJson(json['postsModel']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map = {"postsModel": postsModel.toJson(), "description": description};
    return map;
  }
}
