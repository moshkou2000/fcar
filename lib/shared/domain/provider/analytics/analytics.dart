/// All analytics that used as provider must implement [IAnalytics]
/// modify [IAnalytics] based on your need.
abstract class IAnalytics {
  Future<void> logEvent<T>({
    required String eventName,
    Map<String, dynamic>? data,
  });
  Future<void> setUser({String? userId});
}
