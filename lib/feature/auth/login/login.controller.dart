import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
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

  final formKey = GlobalKey<FormState>();

  Future<void> login({
    required String username,
    required String password,
  }) async {
    await _authRepository.login(username: username, password: password).then(
      (user) async {
        logger.info(user);
        if (user != null) {
          await _saveUser(user: user);
        }
      },
    ).catchError((e, s) {
      logger.error('login', e: e, s: s);
      showErrorDialog(title: 'Error', error: e);
      // ErrorTracking.recordError(e, s);
    });
  }

  Future<void> profile() async {
    await _authRepository.profile().then(
      (profile) async {
        logger.info(profile);
        if (profile != null) {
          await _saveProfile(profile: profile);
        }
      },
    ).catchError((e, s) {
      logger.error('profile', e: e, s: s);
      showErrorDialog(title: 'Error', error: e);
      // FirebaseErrorTracking.recordError(e, s);
    });
  }

  void navigateToLanding() {
    Navigation.pushAndRemoveUntil(NavigationRoute.landingRoute);
  }

  Future<void> _saveProfile({required Object profile}) async {
    _authRepository.saveProfile(profile: profile).catchError((e, s) {
      // ErrorTracking.recordError(e, s);
    });
  }

  Future<void> _saveUser({required Object user}) async {
    _authRepository.saveUser(user: user).catchError((e, s) {
      // ErrorTracking.recordError(e, s);
    });
  }
}
