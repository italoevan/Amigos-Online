import 'package:dart_notification_center/dart_notification_center.dart';

class RegisterChannel {
  static dartNotificationRegister() {
    DartNotificationCenter.registerChannel(channel: 'examples');
    DartNotificationCenter.registerChannel(channel: 'profileIMage');
    DartNotificationCenter.registerChannel(channel: 'profilePosts');
    DartNotificationCenter.registerChannel(channel: 'profileBackgroundColor');
  }
}
