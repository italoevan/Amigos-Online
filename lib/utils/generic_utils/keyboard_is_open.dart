import 'package:flutter/cupertino.dart';

class KeyBoardIsOpen {

  static bool check(BuildContext context){
    if(MediaQuery.of(context).viewInsets.bottom == 0 ){
      return false;
    }else{
      return true;
    }


  }

}