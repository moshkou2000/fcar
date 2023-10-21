import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(state.toString()),
      ),
      body: Center(
        child: HomeView(
          arguments: HomeArgument(title: 'Hometitle'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar:
          ref.read(landingController.notifier).bottomNavigationBar,
    );
  }
}
