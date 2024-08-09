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

  Future<bool> isAuthenticated() async {
    final user = await _authRepository.getUser();
    return user?.hasToken ?? false;
  }

  static Future<void> userAuth({required FutureProviderRef ref}) async {
    final isAuthenticated =
        await ref.read(authProvider.notifier).isAuthenticated();

    // Must remove NativeSplash before navigation
    FlutterNativeSplash.remove();

    if (isAuthenticated) {
      ref.read(navigationProvider.notifier).state =
          NavigationRoute.landingRoute;
    } else {
      ref.read(navigationProvider.notifier).state = NavigationRoute.loginRoute;
    }
  }
}
