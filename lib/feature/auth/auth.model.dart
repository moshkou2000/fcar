import 'package:flutter/foundation.dart';

/// AuthModel is to keep the necessary data for establish Oauth client.
///
/// This class sets for Microsoft Entra ID (Azure Active Directory)
///
/// Change it for other OAuth2.0 services
///
///
/// [tenantId], [clientId], [secret] and [redirectUrl] are required.
///
/// [clientId]
/// - interactive.public
/// - `Azure` ab123053-1111-bbbb-aaaa-1234567890f2
///
/// [redirectUrl] <Bundle ID>://<oauth2 client method>
/// - com.duendesoftware.demo:/oauthredirect
///
/// [scopes]
/// - ['openid', 'profile', 'email', 'offline_access', 'api']
/// - `Azure` ['openid', 'profile', 'email', 'offline_access']
///
/// [authorizationEndpoint] and [tokenEndpoint] are required to create [serviceConfiguration]
/// when there is endSession/logout.
///
/// [authorizationEndpoint]
/// - https://demo.duendesoftware.com/connect/authorize
/// - `Azure` https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize
///
/// [tokenEndpoint]
/// - https://demo.duendesoftware.com/connect/token
/// - `Azure` https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token
@immutable
class AuthModel {
  final String tenantId;
  final String clientId;
  final String secret;

  List<String> get scopes => const ['user.read', 'profile', 'openid', 'email'];
  Uri get redirectUrl => Uri.parse('lr.org.zeroharm://auth');
  Uri get profileEndpoint => Uri.parse('https://graph.microsoft.com/v1.0/me');
  Uri get authorizationEndpoint => Uri.parse(
      'https://login.microsoftonline.com/$tenantId/oauth2/v2.0/authorize');
  Uri get tokenEndpoint => Uri.parse(
      'https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token');

  const AuthModel({
    required this.tenantId,
    required this.clientId,
    required this.secret,
  });
}
