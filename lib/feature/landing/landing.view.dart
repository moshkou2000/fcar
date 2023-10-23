import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme/color/banana_color.dart';
import '../home/home.argument.dart';
import '../home/home.view.dart';
import 'landing.controller.dart';

class LandingView extends ConsumerStatefulWidget {
  const LandingView({super.key});

  @override
  ConsumerState<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends ConsumerState<LandingView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(landingController);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(state.toString()),
      ),
      body: Center(
        child: HomeView(
          arguments: HomeArgument(title: 'Home Title'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomAppBar(
      height: 60,
      color: ThemeColor.primary,
      shape: const CircularNotchedRectangle(),
      notchMargin: 9, //notche margin between floating button and bottom appbar
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            ref.read(landingController.notifier).bottomNavigationBarItems(),
      ),
    );
  }
}
