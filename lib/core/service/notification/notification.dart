import 'notification_message.model.dart';

abstract class INotification {
  Future<String?> get token;
  // Set the background messaging handler early on, as a named top-level function
  Future<void> init();
  Future<void> deleteToken();
  Future<void> requestPermission();

  /// When the app has been opened from a terminated state via push notification
  /// When the app is open and it receives a push notification
  /// When the app is in the background and opened directly from the push notification.
  void handleMessage({
    required Future<void> Function(NotificationMessageModel message) handler,
  });
}

abstract class ILocalNotification {
  Future<String?> get token;
  Future<void> init();
  Future<void> cancel(int id, {String? tag});
  Future<void> cancelAll();
  Future<void> show({
    required NotificationMessageModel notificationMessage,
  }) async {}
}
