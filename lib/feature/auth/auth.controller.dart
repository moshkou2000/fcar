import 'package:flutter_riverpod/flutter_riverpod.dart';

final authController = AutoDisposeNotifierProvider<AuthController, bool>(() {
  return AuthController();
});

class AuthController extends AutoDisposeNotifier<bool> {
  @override
  bool build() {
    ref.onDispose(() {});
    return false;
  }

  Future<void> logout() async {
    // await keystore.clearSession();
    // App.clear();
    // userService.clear();
    // await analytics.setUser(userId: null);
    // Future.delayed(
    //     const Duration(milliseconds: 100),
    //     () async =>
    //         await navigationService.pushAndRemoveUntil(ConstantNav.loginRoute));
    // TODO: clean user data from db
    //
  }
}
