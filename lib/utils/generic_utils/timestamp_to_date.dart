import 'package:intl/intl.dart';

class TimeStampToDate {
  static String convert(String value) {
    var formate = DateFormat('HH:mm a');
    var date = DateTime.parse(value);
    return formate.format(date).toString();
  }
}
