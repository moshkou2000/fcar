import 'package:sentry_flutter/sentry_flutter.dart';

final class NavigationObserver extends SentryNavigatorObserver {
  NavigationObserver() : super(setRouteNameAsTransaction: true);
}
