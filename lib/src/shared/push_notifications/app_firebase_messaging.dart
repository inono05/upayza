import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

Future<void> handleBackgroundHandler(RemoteMessage message) async {
  log("Handling a back msg ==> ${message.messageId}");
}

class AppFirebaseMessaging {
  //final AppPushNotifications appPushNotifications;

  AppFirebaseMessaging();

  Future<void> init() async {
    AppHelpers.requestPermission();
    AppHelpers.initializeNotifications();
    AppHelpers.getDeviceFirebaseToken();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
  }
}
