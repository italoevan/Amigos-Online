class UserModel {
  UserModel();
  String name;
  int n_posts;
  String user_image;
  String user_id;

  UserModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    n_posts = map['n_posts'];
    user_image = map['user_image'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();

    map['name'] = name;
    map['n_posts'] = n_posts;
    map['user_image'] = user_image;
    map['user_id'] = user_id;
    return map;
  }
}
