import 'package:fcar_lib/core/datasource/keystore/keystore.enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/datasource/keystore/keystore.provider.dart';
import 'user.model.dart';

final authRepository = Provider((ref) => AuthRepository());

class AuthRepository {
  Future<UserModel?> getUser() async {
    final result = await keystore.read(key: KeystoreKey.user);
    return result != null && (result as String).isNotEmpty
        ? UserModel.fromJson(result)
        : null;
  }

  Future<void> saveUser({required String user}) async {
    keystore.save(key: KeystoreKey.user, value: user);
  }
}
