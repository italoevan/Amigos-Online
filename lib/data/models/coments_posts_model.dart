class ComentsPostsModel {
  String user_name;
  String user_id;
  String user_image;
  String content;
  String uid;
  String date;

  ComentsPostsModel();

  ComentsPostsModel.fromJson(Map<String, dynamic> map) {
    user_name = map['user_name'];
    user_id = map['user_id'];
    user_image = map['user_image'];
    content = map['content'];
    uid = map['uid'];
    date = map['date'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "user_name": user_name,
      "user_id": user_id,
      "user_image": user_image,
      "content": content,
      "uid" : uid,
      "date": date
    };
    return map;
  }
}
