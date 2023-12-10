import 'package:fcar_lib/core/utility/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme/theme.provider.dart';
import '../../config/theme/theme_color.dart';
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
  late final TabController controller;

  @override
  void initState() {
    // controller = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeSetSystemUIOverlayStyle();
    });
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(landingController);

    return WillPopScope(
      onWillPop: () => onWillPopExit(context: context),
      child: Scaffold(
        key: ref.read(landingController.notifier).scaffoldKey,
        extendBody: true,
        appBar: _appBar(title: state.toString()),
        body: _body(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton(),
        bottomNavigationBar: _bottomNavigationAppBar(),
      ),
    );
  }

  AppBar? _appBar({required String title}) {
    return switch (ref.read(landingController.notifier).currentItem) {
      LandingItemType.home => AppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
          shape: switch (ref.read(landingController.notifier).currentItem) {
            LandingItemType.home => CurvedAppbarShape(),
            // LandingItemType.about => CurvedAppbarShape(),
            _ => null,
          },
          leading: const Icon(Icons.menu),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            )
          ],
        ),
      // LandingItemType.about => CurvedAppbarShape(),
      _ => null,
    };
  }

  Widget _body() {
    return Center(
      child: switch (ref.read(landingController.notifier).currentItem) {
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
      },
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () =>
          ref.read(landingController.notifier).onTapFloatingActionButton(),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  /// The BottomNavigationBar can be a TabBar
  // Widget _bottomNavigationTabBar() {
  //   return TabBar(
  //     controller: controller,
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
      height: 60,
      elevation: 0,
      notchMargin: 9,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      shape: const CircularNotchedRectangle(),
      color: ThemeColor.navigationBarColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bottomNavigationBarItem(
            item: LandingItemType.about,
            icon: Icons.menu,
          ),
          _bottomNavigationBarItem(
            item: LandingItemType.about,
            icon: Icons.people,
          ),
          const SizedBox(width: 60), // notch
          _bottomNavigationBarItem(
            item: LandingItemType.about,
            icon: Icons.search,
          ),
          _bottomNavigationBarItem(
            item: LandingItemType.setting,
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBarItem({
    required IconData icon,
    required LandingItemType item,
  }) {
    final isSelected = ref.read(landingController.notifier).currentItem == item;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.blue[300] : Colors.white),
      onPressed: () =>
          ref.read(landingController.notifier).onTapBottomNavigationBar(item),
    );
  }
}
