import 'package:flutter/material.dart';

final NavigationService navigationService = NavigationService();

class NavigationService {
  static final NavigationService _singleton = NavigationService._internal();
  factory NavigationService() => _singleton;
  NavigationService._internal();

  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  BuildContext? get context => navigationKey.currentState?.overlay?.context;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void pop({dynamic result}) {
    return navigationKey.currentState?.pop(result);
  }

  Future<dynamic> popAndPushTo(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  void popUntil({String? popUntilNamed}) {
    if (popUntilNamed != null) {
      Future.microtask(() => navigationKey.currentState!
          .popUntil(ModalRoute.withName(popUntilNamed)));
    } else {
      Future.microtask(
          () => navigationKey.currentState!.popUntil((route) => route.isFirst));
    }
  }

  /// if removeUntilNamed is null,
  /// remove all screen and make [pushNamed] screen become root
  Future<dynamic> pushAndRemoveUntil(
    String pushNamed, {
    String? removeUntilNamed,
    Object? arguments,
  }) async {
    if (removeUntilNamed != null) {
      return navigationKey.currentState!.pushNamedAndRemoveUntil(
        pushNamed,
        ModalRoute.withName(removeUntilNamed),
        arguments: arguments,
      );
    } else {
      return navigationKey.currentState!.pushNamedAndRemoveUntil(
        pushNamed,
        (route) => false,
        arguments: arguments,
      );
    }
  }

  Future<T?> openPage<T extends Object?>(Widget page) {
    return navigationKey.currentState!
        .push<T>(TagRoute(builder: (_) => page, tag: page.runtimeType));
  }
}

class TagRoute<T> extends MaterialPageRoute<T> {
  final dynamic tag;

  TagRoute({
    required WidgetBuilder builder,
    this.tag,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}
