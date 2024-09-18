import 'package:flutter/material.dart';

import '../../feature/auth/auth.model.dart';

@immutable
abstract final class EnvConstant {
  static AuthModel get oAuth => const AuthModel(
        tenantId: String.fromEnvironment('TENANT_ID'),
        clientId: String.fromEnvironment('CLIENT_ID'),
        secret: String.fromEnvironment('SECRET'),
      );
}
