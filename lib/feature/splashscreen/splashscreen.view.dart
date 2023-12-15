import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'splashscreen.controller.dart';

class SplashscreenView extends ConsumerStatefulWidget {
  const SplashscreenView({super.key});

  @override
  ConsumerState<SplashscreenView> createState() => _SplashscreenViewState();
}

/// Empty screen that prevent user from closing the app
///   until the logic decide where to navigate
class _SplashscreenViewState extends ConsumerState<SplashscreenView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(splashscreenController);

    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(),
      ),
    );
  }
}
