import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/service/navigation/navigation_route.dart';
import '../../shared/shared.module.dart';
import '../auth.repository.dart';

final registerController =
    AutoDisposeNotifierProvider<RegisterController, bool>(() {
  return RegisterController();
});

class RegisterController extends AutoDisposeNotifier<bool> {
  late final AuthRepository _authRepository;
  @override
  bool build() {
    ref.onDispose(() {});
    _authRepository = ref.read(authRepository);
    return false;
  }

  Future<void> onPressedSignUp({
    required String email,
    required String password,
  }) async {
    try {
      await _register(email: email, password: password);
      _navigateToLanding();
    } catch (e, s) {
      logger.error('onPressedSignUp', e: e, s: s);
      showErrorDialog(title: 'Error', error: e);
      // ErrorTracking.recordError(e, s);
    }
  }

  Future<void> _register({
    required String email,
    required String password,
  }) async {
    final result =
        await _authRepository.register(email: email, password: password);

    if (result != null) {
      await _saveUser(user: result.toJson());
    }
  }

  Future<void> _saveUser({required String user}) async {
    _authRepository.saveUser(user: user);
  }

  void _navigateToLanding() {
    Navigation.pushAndRemoveUntil(NavigationRoute.landingRoute);
  }
}
