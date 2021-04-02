class ComentsPostsModel {
  String user_name;
  String user_id;
  String user_image;
  String content;
  String date;

  ComentsPostsModel.fromJson(Map<String, dynamic> map) {
    user_name = map['user_name'];
    user_id = map['user_id'];
    user_image = map['user_image'];
    content = map['content'];
    date = map['date'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "user_name": user_name,
      "user_id": user_id,
      "user_image": user_image,
      "content": content,
      "date": date
    };
    return map;
  }
}
