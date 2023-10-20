import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../notification_message.model.dart';

// setup default
const bool _useDefaultNotificationDetails = false;

@immutable
abstract final class LocalNotification {
// Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // TODO: implement token
  Future<String?> get token => throw UnimplementedError();

  static Future<void> setup() async {
    // Initialization setting for android
    const initializationSettingsAndroid = InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_launcher'));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  /// final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  /// String? title, // message.notification?.title,
  /// String? body, // message.notification?.body,
  /// String? payload, // message.data['route'], -> [route] is a random key
  ///
  static Future<void> show({
    required NotificationMessageModel notificationMessage,
  }) async {
    // To display the notification in device
    try {
      await _notificationsPlugin.show(
        notificationMessage.id,
        notificationMessage.title,
        notificationMessage.body,
        notificationMessage.notificationDetails ??
            (_useDefaultNotificationDetails
                ? _getNotificationDetails(
                    sound: notificationMessage
                        .notificationDetails?.android?.sound?.sound,
                    channelId: notificationMessage
                        .notificationDetails?.android?.sound?.sound,
                    channelName: notificationMessage
                        .notificationDetails?.android?.sound?.sound,
                  )
                : null),
        payload: notificationMessage.payload,
      );
    } catch (e) {
      if (kDebugMode) {
        print('LocalNotificationService.show: ${e.toString()}');
      }
    }
  }

  static Future<void> cancel(int id, {String? tag}) async {
    await _notificationsPlugin.cancel(id, tag: tag);
  }

  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }

  static NotificationDetails _getNotificationDetails({
    String? channelId,
    String? channelName,
    String? sound,
  }) {
    // To display the notification in device
    return NotificationDetails(
      android: AndroidNotificationDetails(
          channelId ?? 'Channel Id', channelName ?? 'Main Channel',
          groupKey: sound ?? 'gfg',
          color: Colors.green,
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound(sound ?? 'gfg'),
          // different sound for
          // different notification
          playSound: true,
          priority: Priority.high),
    );
  }
}
