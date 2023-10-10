import 'package:flutter/material.dart';

import '../feature/home/home.argument.dart';
import '../feature/home/home.view.dart';

class ConstantNav {
  ConstantNav();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigatorState => navigatorKey.currentState;

// route path
  static const String homeRoute = '/home';
  static const String previewRoute = '/preview';
  static const String landingRoute = '/landing';
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String photoPreviewRoute = '/photoViewer';
  static const String versionRoute = '/version';

  static MaterialPageRoute _pageRoute(
    Widget page, {
    bool isFullscreenDialog = false,
  }) {
    return MaterialPageRoute(
        builder: (_) => page, fullscreenDialog: isFullscreenDialog);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _pageRoute(
            HomeView(arguments: settings.arguments as HomeArgument));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
