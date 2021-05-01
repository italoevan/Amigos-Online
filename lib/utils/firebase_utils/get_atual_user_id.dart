import 'package:firebase_auth/firebase_auth.dart';

class GetAtualUserId {
  FirebaseAuth auth = FirebaseAuth.instance;

  String getUserId() {
    String response = auth.currentUser.uid;
    return response;
  }

  bool isSameUser(String id) {
    if(auth.currentUser.uid == id){
      return true;
    }
    return false;

  }
}
