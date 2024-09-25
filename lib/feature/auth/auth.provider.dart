import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/service/navigation/navigation_route.dart';
import 'auth.repository.dart';

final authProvider = NotifierProvider<AuthProvider, bool>(() {
  return AuthProvider();
});

class AuthProvider extends Notifier<bool> {
  late final AuthRepository _authRepository;
  @override
  bool build() {
    _authRepository = ref.read(authRepository);
    return false;
  }

  /// Call in App.init
  ///
  static Future<void> auth({required FutureProviderRef ref}) async {
    final isAuthenticated =
        await ref.read(authProvider.notifier).isAuthenticated();

    // Must remove NativeSplash before navigation
    FlutterNativeSplash.remove();

    if (isAuthenticated) {
      _navigateToLanding(ref);
    } else {
      _navigateToAuth(ref);
    }
  }

  Future<bool> isAuthenticated() async {
    final user = await _authRepository.getAuthData();
    return user?.hasToken ?? false;
  }

  static void _navigateToLanding(FutureProviderRef ref) {
    ref.read(navigationProvider.notifier).state = NavigationRoute.landingRoute;
  }

  static void _navigateToAuth(FutureProviderRef ref) {
    ref.read(navigationProvider.notifier).state = NavigationRoute.authRoute;
  }
}
