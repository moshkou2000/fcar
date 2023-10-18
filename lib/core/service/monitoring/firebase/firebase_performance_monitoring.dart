import '../performance_monitoring.dart';

class FirebasePerformanceMonitoring implements IPerformanceMonitoring {
  static final FirebasePerformanceMonitoring _singleton =
      FirebasePerformanceMonitoring._internal();
  factory FirebasePerformanceMonitoring() => _singleton;
  FirebasePerformanceMonitoring._internal();
}
