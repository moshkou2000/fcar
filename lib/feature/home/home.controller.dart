import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeController = AutoDisposeNotifierProvider<HomeController, bool>(() {
  return HomeController();
});

class HomeController extends AutoDisposeNotifier<bool> {
  @override
  bool build() {
    ref.onDispose(() {});
    return false;
  }
}
