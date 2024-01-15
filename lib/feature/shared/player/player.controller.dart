import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base.controller.dart';
import '../../../core/service/navigation/navigation_route.dart';
import '../../about/about.argument.dart';
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

  void navigateToAbout() {
    if (state != null) {
      Navigation.navigateTo(NavigationRoute.aboutRoute,
          arguments:
              AboutArgument(title: state!.displayname, playerInfo: state!));
    }
  }
}
