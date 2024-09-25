import 'package:fcar_lib/core/service/auth/remote/remote_auth_config.model.dart';
import 'package:flutter/material.dart';

@immutable
abstract final class EnvConstant {
  static RemoteAuthConfigModel get azureAuth => RemoteAuthConfigModel.azure(
        tenantId: const String.fromEnvironment('TENANT_ID'),
        clientId: const String.fromEnvironment('CLIENT_ID'),
        redirectUrl: Uri.parse('lr.org.zeroharm://auth'),
      );
}
