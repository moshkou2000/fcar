import 'package:fcar_lib/core/service/auth/remote/remote_auth.dart';
import 'package:fcar_lib/core/service/auth/remote/remote_auth_config.model.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.provider.dart';
import '../../config/constant/env.constant.dart';
import '../../core/service/localization/localization.dart';
import '../../core/service/navigation/navigation_route.dart';
import 'auth.repository.dart';

final authController = AutoDisposeNotifierProvider<AuthController, String>(() {
  return AuthController();
});

class AuthController extends AutoDisposeNotifier<String> {
  late final AuthRepository _authRepository;
  late final RemoteAuthConfigModel _authModel;

  @override
  String build() {
    ref.onDispose(() {});
    _authRepository = ref.read(authRepository);
    _authModel = EnvConstant.azureAuth;
    return '';
  }

  Future<void> authentication() async {
    final result = await RemoteAuth.authentication(
      _authModel,
      Navigation.context!,
      Localization.authentication,
    );

    if (result != null) {
      _saveAuthData(result.toJson());

      network.headers.addAll({'Authorization': 'Bearer ${result.accessToken}'});

      final String? id;
      final String? displayname;
      final String? username;
      final String? accessToken;
      final String? refreshToken;
      final Map<String, dynamic>? additionalParameters;

      Navigation.popAndPushTo(NavigationRoute.landingRoute);
    } else {
      state =
          'Could not proceed your request. Please contact customer service.';
    }
  }

  Future<void> _saveAuthData(String user) async {
    await _authRepository.saveAuthData(user: user);
  }
}
