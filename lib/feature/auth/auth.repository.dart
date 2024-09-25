import 'package:fcar_lib/core/service/auth/remote/remote_auth.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.provider.dart';
import '../../config/keystore.enum.dart';

final authRepository = Provider((ref) => AuthRepository());

class AuthRepository {
  Future<RemoteAuthModel?> getAuthData() async {
    final result = await keystore.read(key: KeystoreKey.user.name);
    return result != null && (result as String).isNotEmpty
        ? RemoteAuthModel.fromJson(result)
        : null;
  }

  Future<void> saveAuthData({required String user}) async {
    keystore.save(key: KeystoreKey.user.name, value: user);
  }
}
