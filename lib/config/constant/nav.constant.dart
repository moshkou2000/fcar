import 'package:flutter/material.dart';

import '../../feature/home/home.argument.dart';
import '../../feature/home/home.view.dart';
import '../../feature/landing/landing.view.dart';

@immutable
abstract final class ConstantNav {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigatorState => navigatorKey.currentState;

// route path
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String homeRoute = '/home';
  static const String landingRoute = '/landing';
  static const String loginRoute = '/login';
  static const String photoPreviewRoute = '/photoViewer';
  static const String previewRoute = '/preview';
  static const String versionRoute = '/version';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _pageRoute(
            HomeView(arguments: settings.arguments as HomeArgument));
      case landingRoute:
        return _pageRoute(const LandingView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static MaterialPageRoute _pageRoute(
    Widget page, {
    bool isFullscreenDialog = false,
  }) {
    return MaterialPageRoute(
        builder: (_) => page, fullscreenDialog: isFullscreenDialog);
  }
}
