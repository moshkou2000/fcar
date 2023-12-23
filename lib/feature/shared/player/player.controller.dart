import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base.controller.dart';
import '../../auth/player.model.dart';
import 'player.repository.dart';

final playerController =
    AutoDisposeNotifierProvider<PlayerController, PlayerModel?>(() {
  return PlayerController();
});

class PlayerController extends BaseController<PlayerModel?> {
  late final PlayerRepository _playerRepository;

  @override
  PlayerModel? build() {
    ref.onDispose(() {});
    _playerRepository = ref.read(playerRepository);
    getProfile();
    return null;
  }

  Future<void> getProfile() async => state = await _playerRepository.profile;
}
