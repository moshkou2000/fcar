import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  final formKey = GlobalKey<FormState>();

  bool get isValid => formKey.currentState?.validate() ?? false;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _authRepository.register(email: email, password: password).then(
      (user) async {
        if (user != null) {
          await _saveUser(user: user);
        }
      },
    ).catchError((e) {
      showErrorDialog(error: e);
      // ErrorTracking.recordError(e, s);
    });
  }

  Future<void> _saveUser({required Object user}) async {
    _authRepository.saveUser(user: user).catchError((e, s) {
      // ErrorTracking.recordError(e, s);
    });
  }
}
