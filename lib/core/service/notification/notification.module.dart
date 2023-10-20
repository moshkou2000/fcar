/// Reference to the given notification dataset
/// export only one local & remote
///
export 'local/flutter_local_notification.dart';
export 'remote/firebase_messaging.dart';

/// each [*_analytics.dart] must implement the [Analytics]
/// duplicate the code and complete the functions body.
///
/// @immutable
/// final class RemoteNotification {
///   static Future<String?> get token async =>...;
///   static void setup() {...}
///   static Future<void> init() async {...}
///   static Future<void> deleteToken() async {...}
///   static Future<void> requestPermission() async {...}
///
///   /// When the app has been opened from a terminated state via push notification
///   /// suggested to call in [initState]
///   static Future<void> checkInitialMessage() async {...}
/// }

/// @immutable
/// final class LocalNotification {
///   Future<String?> get token => ...;
///   static Future<void> init() async {...}
///
///   /// final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
///   /// String? title, // message.notification?.title,
///   /// String? body, // message.notification?.body,
///   /// String? payload, // message.data['route'], -> [route] is a random key
///   /// 
///   static Future<void> show({
///     required NotificationMessageModel notificationMessage,
///   }) async {...}
///   static Future<void> cancel(int id, {String? tag}) async {...}
///   static Future<void> cancelAll() async {...}