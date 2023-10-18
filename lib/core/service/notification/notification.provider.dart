import 'local/flutter_local_notification.dart';
import 'remote/firebase_messaging.dart';
import 'notification.dart';

final INotification notification = FirebaseMessagingService();
final ILocalNotification localNotification = FlutterLocalNotificationService();
