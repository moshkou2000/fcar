import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme/color.module.dart';
import '../../shared/base.controller.dart';

final landingController =
    AutoDisposeNotifierProvider<LandingController, bool>(() {
  return LandingController();
});

/// 0: first index is initial
final indexController = StateProvider<int>((ref) => 0);

class LandingController extends BaseController<bool> {
  @override
  bool build() {
    ref.onDispose(() {
      ref.read(indexController.notifier).dispose();
    });
    return false;
  }

  BottomNavigationBar get bottomNavigationBar => BottomNavigationBar(
        selectedItemColor: ThemeColor.primary,
        currentIndex: ref.read(indexController.notifier).state,
        iconSize: 50,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        onTap: (int index) {
          ref.read(indexController.notifier).state = index;
          toggleState();
        },
      );
}
