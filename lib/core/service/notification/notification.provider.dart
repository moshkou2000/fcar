import 'local/flutter_local_notification.dart';
import 'remote/firebase_messaging.dart';
import 'notification.dart';

abstract class NotificationProvider {
  late final INotification notification;
  late final ILocalNotification localNotification;

  NotificationProvider() {
    _createRemoteService();
    _createLocalService();
  }

  void _createRemoteService() {
    notification = FirebaseMessagingService();
  }

  void _createLocalService() {
    localNotification = FlutterLocalNotificationService();
  }
}
