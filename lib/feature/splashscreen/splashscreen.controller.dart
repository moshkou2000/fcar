import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/app.dart';
import '../../core/base.controller.dart';
import '../../core/service/navigation/navigation_route.dart';
import 'splashscreen.repository.dart';

final splashscreenController =
    AutoDisposeNotifierProvider<SplashscreenController, bool>(() {
  return SplashscreenController();
});

class SplashscreenController extends BaseController<bool> {
  late final SplashscreenRepository _splashscreenRepository;
  @override
  bool build() {
    ref.onDispose(() {});
    _splashscreenRepository = ref.read(splashscreenRepository);
    _init();
    return false;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Must remove NativeSplash before navigation
  Future<void> _init() async {
    await App.init();
    FlutterNativeSplash.remove();
    await navigateTo();
  }

  Future<void> navigateTo() async {
    final user = await _splashscreenRepository.getUser();
    if (user != null && user.hasToken) {
      Navigation.pushAndRemoveUntil(NavigationRoute.landingRoute);
    } else {
      Navigation.pushAndRemoveUntil(NavigationRoute.loginRoute);
    }
  }
}
