import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/service/navigation/navigation_route.dart';
import '../../shared/shared.module.dart';
import '../auth.repository.dart';

final loginController = AutoDisposeNotifierProvider<AuthController, bool>(() {
  return AuthController();
});

class AuthController extends AutoDisposeNotifier<bool> {
  late final AuthRepository _authRepository;
  @override
  bool build() {
    ref.onDispose(() {});
    _authRepository = ref.read(authRepository);
    return false;
  }

  Future<void> onPressedSignIn({
    required String username,
    required String password,
  }) async {
    try {
      await _login(username: username, password: password);
      await _profile();
      _navigateToLanding();
    } catch (e, s) {
      logger.error('onPressedSignIn', e: e, s: s);
      showErrorDialog(title: 'Error', error: e);
      // ErrorTracking.recordError(e, s);
    }
  }

  Future<void> _login({
    required String username,
    required String password,
  }) async {
    final result =
        await _authRepository.login(username: username, password: password);
    if (result != null) {
      await _saveUser(user: result.toJson());
    }
  }

  Future<void> _profile() async {
    final result = await _authRepository.profile();
    if (result != null) {
      await _saveProfile(profile: result.toJson());
    }
  }

  Future<void> _saveProfile({required String profile}) async {
    _authRepository.saveProfile(profile: profile);
  }

  Future<void> _saveUser({required String user}) async {
    _authRepository.saveUser(user: user);
  }

  void _navigateToLanding() {
    Navigation.pushAndRemoveUntil(NavigationRoute.landingRoute);
  }
}
