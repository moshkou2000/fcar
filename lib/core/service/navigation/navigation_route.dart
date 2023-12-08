import 'package:flutter/material.dart';

import '../../../feature/auth/login/login.view.dart';
import '../../../feature/auth/register/register.view.dart';
import '../../../feature/ecommerce/cart/cart.view.dart';
import '../../../feature/ecommerce/category/category.argument.dart';
import '../../../feature/ecommerce/category/category.view.dart';
import '../../../feature/ecommerce/ecommerce.view.dart';
import '../../../feature/ecommerce/product/product.argument.dart';
import '../../../feature/ecommerce/product/product.view.dart';
import '../../../feature/home/home.argument.dart';
import '../../../feature/home/home.view.dart';
import '../../../feature/landing/landing.view.dart';
import '../../../feature/splashscreen/splashscreen.view.dart';

@immutable
abstract final class NavigationRoute {
// route path
  static const String cartRoute = '/cart';
  static const String categoryRoute = '/category';
  static const String ecommerceRoute = '/ecommerce';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String homeRoute = '/home';
  static const String landingRoute = '/landing';
  static const String loginRoute = '/login';
  static const String photoPreviewRoute = '/photoViewer';
  static const String previewRoute = '/preview';
  static const String productRoute = '/product';
  static const String registerRoute = '/register';
  static const String splashscreenRoute = '/splashscreen';
  static const String versionRoute = '/version';

  /// call in [MaterialApp.onGenerateRoute]
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case cartRoute:
        return _pageRoute(const CartView());
      case categoryRoute:
        return _pageRoute(
            CategoryView(arguments: settings.arguments as CategoryArgument));
      case ecommerceRoute:
        return _pageRoute(const EcommerceView());
      case homeRoute:
        return _pageRoute(
            HomeView(arguments: settings.arguments as HomeArgument));
      case landingRoute:
        return _pageRoute(const LandingView());
      case loginRoute:
        return _pageRoute(const LoginView());
      case previewRoute:
        return _pageRoute(
            ProductView(arguments: settings.arguments as ProductArgument));
      case registerRoute:
        return _pageRoute(const RegisterView());
      case splashscreenRoute:
        return _pageRoute(const SplashscreenView());
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
