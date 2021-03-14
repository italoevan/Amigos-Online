class PostsModel {
  String tag;
  String content;
  String user_name;
  String user_id;
  String user_image;
  String date;

  PostsModel.fromJson(Map<String, dynamic> map) {
    tag = map['tag'];
    content = map['content'];
    user_name = map['user_name'];
    user_id = map['user_id'];
    user_image = map['user_image'];
    date = map['date'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['tag'] = tag;
    map['content'] = content;
    map['user_name'] = user_name;
    map['user_id'] = user_id;
    map['user_image'] = user_image;
    map['date'] = date;
    return map;
  }
}
