import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NickNameEndpoints{
   Future post({@required FirebaseFirestore firebaseFirestore, @required id, @required Map<String, dynamic> map}) => firebaseFirestore.collection('users').doc(id).update(map);
  

}