import 'analytics.dart';
import 'error_tracking.dart';
import 'firebase/firebase_analytics.dart';
import 'firebase/firebase_error_tracking.dart';
import 'firebase/firebase_performance_monitoring.dart';
import 'performance_monitoring.dart';

/// FirebaseAnalytics | SentryAnalytics | DatadogAnalytics;
final IAnalytics analytics = FirebaseAnalytics();

/// FirebaseErrorTracking | SentryErrorTracking | DatadogErrorTracking;
final IErrorTracking errorTracking = FirebaseErrorTracking();

/// FirebasePerformanceMonitoring | SentryPerformanceMonitoring | DatadogPerformanceMonitoring;
final IPerformanceMonitoring performanceMonitoring =
    FirebasePerformanceMonitoring();
