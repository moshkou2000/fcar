/// Reference to the given navigation observer dataset
/// export only one
// export 'datadog/datadog_navigation_observer.dart';
// export 'firebase/firebase_navigation_observer.dart';
export 'sentry/sentry_navigation_observer.dart';

/// each [*_navigation_observer.dart] must implement the [NavigationObserver]
/// duplicate the code and complete the functions body.
///
/// final class NavigationObserver extends [*NavigatorObserver] {
///   NavigationObserver() : super([pass the super arguments]);
/// }
/// 