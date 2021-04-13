import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:regexpattern/regexpattern.dart' as P;

class TimeStampToDate {
  static String convert(String value) {
    final intValue = int.parse(value.replaceAll(RegExp('[^0-9]'), ''));
    var date = DateTime.fromMicrosecondsSinceEpoch(intValue);
    var format = DateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedValue = format.format(date);
    return formattedValue.toString();
  }
}
