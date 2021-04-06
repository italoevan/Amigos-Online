import 'package:amigos_online/data/models/coments_posts_model.dart';
import 'package:amigos_online/data/models/posts_model.dart';
import 'package:amigos_online/data/provider/others_coments_provider/other_comments_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtherCommentsRepository {
  OtherCommentsRepository({@required this.provider});

  final OtherComentsProvider provider;

  Future getOthersUsersComents({@required PostsModel model}) async{
    try{  
      QuerySnapshot response = await provider.getOthersUsersComents(model: model);
     List<ComentsPostsModel> list = [];
      response.docs.forEach((element) {
        list.add(ComentsPostsModel.fromJson(element.data()));
       });
      return list;
    }catch(e){
      return e;
    }
  }

}
