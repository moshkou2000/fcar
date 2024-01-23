import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/base.controller.dart';
import '../../core/service/navigation/navigation_route.dart';
import '../game/opponent/opponent.argument.dart';
import 'landing_item_type.dart';

final landingController =
    AutoDisposeNotifierProvider<LandingController, bool>(() {
  return LandingController();
});

final _itemController =
    StateProvider<LandingItemType>((ref) => LandingItemType.home);

class LandingController extends BaseController<bool> {
  @override
  bool build() {
    ref.onDispose(() {
      ref.read(_itemController.notifier).dispose();
    });
    return false;
  }

  LandingItemType get currentItem => ref.read(_itemController.notifier).state;

  void onTapFloatingActionButton() {
    Navigation.navigateTo(NavigationRoute.opponentRoute,
        arguments: OpponentArgument(title: 'Game Title'));
  }

  void onTapBottomNavigationBar(LandingItemType item) {
    ref.read(_itemController.notifier).state = item;
    toggleState();
  }
}
