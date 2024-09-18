import 'dart:convert';

import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oauth2/oauth2.dart';

import '../../config/constant/env.constant.dart';
import '../../core/service/localization/localization.dart';
import '../../core/service/navigation/navigation_route.dart';
import '../webview/webview.argument.dart';
import 'auth.model.dart';
import 'auth.repository.dart';
import 'user.model.dart';

final authController = AutoDisposeNotifierProvider<AuthController, String>(() {
  return AuthController();
});

class AuthController extends AutoDisposeNotifier<String> {
  late final AuthRepository _authRepository;
  late final AuthModel _authModel;

  @override
  String build() {
    ref.onDispose(() {});
    _authRepository = ref.read(authRepository);
    _authModel = EnvConstant.oAuth;
    return '';
  }

  void authentication() {
    // Create an authorization grant
    var grant = AuthorizationCodeGrant(
      _authModel.clientId,
      _authModel.authorizationEndpoint,
      _authModel.tokenEndpoint,
    );

    // Build the authorization URL
    var authorizationUrl = grant.getAuthorizationUrl(_authModel.redirectUrl,
        scopes: _authModel.scopes);

    _navigateToAuth(authorizationUrl, grant);
  }

  Future<void> _navigateToAuth(
    Uri authorizationUrl,
    AuthorizationCodeGrant grant,
  ) async {
    final result = await Navigation.navigateTo(
      NavigationRoute.webviewRoute,
      arguments: WebviewArgument(
        title: Localization.authentication,
        url: authorizationUrl,
        onUrlChange: (url) async {
          if (url != null) {
            await _handleAuth(url, grant);
          }
        },
        onError: () {},
        hasCloseButton: false,
      ),
    );

    var r = result as MapEntry<bool, String>;
    if (r.key == true) {
      Navigation.popAndPushTo(NavigationRoute.landingRoute);
    } else {
      state = r.value;
    }
  }

  Future<void> _handleAuth(
    String url,
    AuthorizationCodeGrant grant,
  ) async {
    if (url.contains(_authModel.redirectUrl.toString()) == true) {
      logger.info(url);

      // Extract the authorization code from the URL
      final uri = Uri.parse(url);
      final code = uri.queryParameters['code'];

      if (code != null) {
        try {
          // Exchange the authorization code for tokens
          final client =
              await grant.handleAuthorizationResponse({'code': code});

          // Store the access token and refresh token to make API requests
          // TODO: accessToken & refreshToken
          logger.trace('::accessToken: ${client.credentials.accessToken}');
          logger.trace('::refreshToken: ${client.credentials.refreshToken}');

          var response = await client.get(_authModel.profileEndpoint);

          if (response.statusCode == 200) {
            final Map<String, dynamic> parameters = jsonDecode(response.body);
            var user = UserModel(
              id: parameters['id'],
              displayname: parameters['displayName'],
              username: parameters['mail'],
              accessToken: client.credentials.accessToken,
              refreshToken: client.credentials.refreshToken,
            );

            // Store the user profile
            await _saveUser(user.toJson());

            // Return syccess
            Navigation.pop(result: MapEntry(true, user));
            return;
          } else {
            logger.error('Failed to fetch user data: ${response.statusCode}');

            // log the error in crashlytics
            // DataDogErrorTracking.recordError(e, s);

            // Return failure
            Navigation.pop(
                result: const MapEntry(false,
                    'Could not get user data. You may contact support team.'));
            return;
          }
        } catch (e, s) {
          logger.error(e);

          // log the error in crashlytics
          // DataDogErrorTracking.recordError(e, s);

          // Return failure
          Navigation.pop(
              result: const MapEntry(false,
                  'Could not connect to autorization server. You may contact support team.'));
          return;
        }
      }

      // log the error in crashlytics
      // DataDogErrorTracking.recordError(e, s);

      // Return failure
      Navigation.pop(
          result: const MapEntry(false,
              'Could not proceed your request. Please contact customer service.'));
    }
  }

  Future<void> _saveUser(String user) async {
    await _authRepository.saveUser(user: user);
  }
}
