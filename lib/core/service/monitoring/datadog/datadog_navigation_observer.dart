import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';

final class NavigationObserver extends DatadogNavigationObserver {
  NavigationObserver() : super(datadogSdk: DatadogSdk.instance);
}
