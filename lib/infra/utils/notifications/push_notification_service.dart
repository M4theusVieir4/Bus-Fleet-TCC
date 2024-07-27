import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationsService {
  static Future<void> initialize() async {
    try {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      OneSignal.initialize("f0587b59-2a26-4928-9ab4-dfbc2830b596");
      OneSignal.Notifications.requestPermission(true);
    } catch (e, stack) {}
  }
}
