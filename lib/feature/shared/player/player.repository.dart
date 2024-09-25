import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app.provider.dart';
import '../../../config/keystore.enum.dart';
import '../../auth/player.model.dart';

final playerRepository = Provider((ref) => PlayerRepository());

class PlayerRepository {
  Future<PlayerModel?> get profile async {
    final message = await keystore.read(key: KeystoreKey.profile.name);
    logger.info(message);
    final result =
        await keystore.read(key: KeystoreKey.profile.name).catchError((e, s) {
      logger.error('player', e: e, s: s);
    });
    return result != null ? PlayerModel.fromJson(result) : null;
  }
}
