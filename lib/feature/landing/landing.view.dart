import 'package:fcar_lib/config/extension/context.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/constant/asset.constant.dart';
import '../about/about.argument.dart';
import '../about/about.view.dart';
import '../home/home.argument.dart';
import '../home/home.view.dart';
import '../record/record.argument.dart';
import '../record/record.view.dart';
import '../setting/setting.argument.dart';
import '../setting/setting.view.dart';
import '../shared/shared.module.dart';
import 'landing.controller.dart';
import 'landing_item_type.dart';

class LandingView extends ConsumerStatefulWidget {
  const LandingView({super.key});

  @override
  ConsumerState<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends ConsumerState<LandingView>
    with SingleTickerProviderStateMixin {
  // late final TabController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(landingController);

    // TODO: state.toString() is for test, set the page title
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationAppBar(),
    );
  }

  Widget? _body() {
    return switch (ref.read(landingController.notifier).currentItem) {
      LandingItemType.home => HomeView(
          arguments: HomeArgument(title: 'Home Title'),
        ),
      LandingItemType.about => AboutView(
          arguments: AboutArgument(title: 'About Title'),
        ),
      LandingItemType.setting => SettingView(
          arguments: SettingArgument(title: 'Setting Title'),
        ),
      LandingItemType.record => RecordView(
          arguments: RecordArgument(title: 'Record Title'),
        ),
      LandingItemType.exit => null,
    };
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      elevation: 0,
      onPressed: () =>
          ref.read(landingController.notifier).onTapFloatingActionButton(),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  /// The BottomNavigationBar can be a TabBar
  // Widget _bottomNavigationTabBar() {
  //   return TabBar(
  //     controller: _controller,
  //     unselectedLabelColor: Colors.grey,
  //     labelColor: Colors.blue,
  //     onTap: (index) {},
  //     tabs: const [
  //       Tab(icon: Icon(Icons.menu_rounded)),
  //       Tab(icon: Icon(Icons.piano)),
  //       Tab(icon: Icon(Icons.car_rental_rounded)),
  //       Tab(icon: Icon(Icons.settings_rounded)),
  //     ],
  //   );
  // }

  /// The BottomNavigationBar can be a BottomAppBar
  Widget _bottomNavigationAppBar() {
    return BottomAppBar(
      height: 144,
      elevation: 0,
      notchMargin: 8,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _bottomNavigationBarItem(
              svgIcon: AssetConstant.googleIcon,
              title: LandingItemType.exit.name,
              onPressed: () => context.showSnackBar('Create your function.'),
            ),
            const Spacer(flex: 5),
            _bottomNavigationBarItem(
              svgIcon: AssetConstant.googleIcon,
              title: LandingItemType.record.name,
              onPressed: () => ref
                  .read(landingController.notifier)
                  .onTapBottomNavigationBar(LandingItemType.record),
            ),
            const Spacer(),
            // const SizedBox(width: 60), // notch
            _bottomNavigationBarItem(
              svgIcon: AssetConstant.sunCloudIcon,
              title: LandingItemType.about.name,
              onPressed: () => ref
                  .read(landingController.notifier)
                  .onTapBottomNavigationBar(LandingItemType.about),
              badge: const Icon(Icons.check, color: Colors.white, size: 5),
            ),
            const Spacer(),
            _bottomNavigationBarItem(
              svgIcon: AssetConstant.googleIcon,
              title: LandingItemType.setting.name,
              onPressed: () => ref
                  .read(landingController.notifier)
                  .onTapBottomNavigationBar(LandingItemType.setting),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBarItem({
    required String svgIcon,
    required String title,
    required void Function()? onPressed,
    Widget? badge,
  }) {
    // final isSelected = ref.read(landingController.notifier).currentItem == item;
    return textIconButton(
      image: svgIcon,
      title: title,
      onPressed: onPressed,
      badge: badge,
    );
  }
}
