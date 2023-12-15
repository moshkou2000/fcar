import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';

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

  // Must remove NativeSplash before navigation
  Future<void> _init() async {
    Future.microtask(() async {
      App.init();
      final user = await _splashscreenRepository.getUser();
      FlutterNativeSplash.remove();
      navigateTo(user?.hasToken ?? false);
    });
  }

  void navigateTo(bool userHasToken) {
    if (userHasToken) {
      Navigation.pushAndRemoveUntil(NavigationRoute.landingRoute);
    } else {
      Navigation.pushAndRemoveUntil(NavigationRoute.loginRoute);
    }
  }
}
