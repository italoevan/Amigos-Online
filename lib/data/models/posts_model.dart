

class PostsModel {
  String tag;
  String content;
  String user_name;
  String user_id;

  String date;
  String uid;

  PostsModel();

  //to get
  PostsModel.fromJson(Map<String, dynamic> map) {
    tag = map['tag'];
    content = map['content'];
    user_name = map['user_name'];
    user_id = map['user_id'];
    date = map['date'];
    uid = map['uid'];
  }

  //to send to database
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['tag'] = tag;
    map['content'] = content;
    map['user_name'] = user_name;
    map['user_id'] = user_id;
    map['date'] = date;
    map['uid'] = uid;
    return map;
  }
}
