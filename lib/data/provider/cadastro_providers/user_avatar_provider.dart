import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserAvatarProvider {
  UserAvatarProvider({@required this.storage, @required this.firestore});

  final FirebaseStorage storage;
  final FirebaseFirestore firestore;

  Future setUserImage({@required File file, @required String id}) async {
    var reference =
        await storage.ref().child('/profile_images').child(id).putFile(file);
    var link = await reference.ref.getDownloadURL();

    Map<String, dynamic> map = {"user_image": link};

    await firestore.collection('users').doc(id).update(map);
    print(link);
    return link;
  }
}
