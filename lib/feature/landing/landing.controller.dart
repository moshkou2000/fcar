import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/base.controller.dart';
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
    ref.read(_itemController.notifier).state = LandingItemType.home;
    toggleState();
  }

  void onTapBottomNavigationBar(LandingItemType item) {
    ref.read(_itemController.notifier).state = item;
    toggleState();
  }
}
