import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/base.controller.dart';

final landingController =
    AutoDisposeNotifierProvider<LandingController, bool>(() {
  return LandingController();
});

/// 0: first index is initial
final _indexController = StateProvider<int>((ref) => 0);

class LandingController extends BaseController<bool> {
  @override
  bool build() {
    ref.onDispose(() {
      ref.read(_indexController.notifier).dispose();
    });
    return false;
  }

  int get currentIndex => ref.read(_indexController.notifier).state;

  List<Widget> bottomNavigationBarItems() {
    return [
      IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.people, color: Colors.white),
        onPressed: () {},
      ),
      const SizedBox(width: 60),
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.print, color: Colors.white),
        onPressed: () {},
      ),
    ];
  }

  void onTapBottomNavigationBar(int index) {
    ref.read(_indexController.notifier).state = index;
    toggleState();
  }
}
