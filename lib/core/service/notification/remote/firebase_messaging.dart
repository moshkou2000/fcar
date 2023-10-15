import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../notification.dart';
import '../notification_message.model.dart';

class FirebaseMessagingService implements INotification {
  static Future<void> Function(NotificationMessageModel message)? _handler;

  @override
  Future<String?> get token async =>
      await FirebaseMessaging.instance.isSupported()
          ? Platform.isIOS
              ? await FirebaseMessaging.instance.getAPNSToken()
              : await FirebaseMessaging.instance.getToken()
          : null;

  FirebaseMessagingService() {
    // called when the new FCM token is generated
    FirebaseMessaging.instance.onTokenRefresh.listen(_onTokenRefresh);
    // called when the app is in the foreground and we receive a push notification
    FirebaseMessaging.onMessage.listen(_onForeground);
    // called when the app is in the background and its opened from the push notification
    FirebaseMessaging.onMessageOpenedApp.listen(_onBackground);
  }

  static void setup() {
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_onBackground);
  }

  @override
  Future<void> init() async {
    try {
      // Prompts the user for notification permissions
      await requestPermission();
      // If the application has been opened from a terminated state via push notification
      await checkInitialMessage();
    } catch (e) {
      debugPrint('fcmToken onTokenRefresh : ${e.toString}');
    }
  }

  @override
  Future<void> deleteToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  @override
  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
  }

  /// When the app has been opened from a terminated state via push notification
  /// suggested to call in [initState]
  Future<void> checkInitialMessage() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (kDebugMode) {
      print('checkInitialMessage: $message');
    }
    if (message != null) {
      _handleMessage(message);
    }
  }

  void _onTokenRefresh(String token) {
    if (kDebugMode) {
      print('_onTokenRefresh: $token');
    }
    // TODO: notification logic
  }

  // When the app is open and it receives a push notification
  Future<void> _onForeground(RemoteMessage message) async {
    if (kDebugMode) {
      print('_onForeground: ${message.toString()}');
    }
    _handleMessage(message);
  }

  // When the app is in the background and opened directly from the push notification.
  static Future<void> _onBackground(RemoteMessage message) async {
    if (kDebugMode) {
      print('_onBackground: ${message.toString()}');
    }
    _handleMessage(message);
  }

  static void _handleMessage(RemoteMessage message) {
    _handler?.call(NotificationMessageModel(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
      // notificationDetails,
    ));
  }

  @override
  void handleMessage({
    required Future<void> Function(NotificationMessageModel message) handler,
  }) =>
      _handler = handler;
}
