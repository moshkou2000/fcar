import 'package:fcar_lib/config/extension/context.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../about/about.argument.dart';
import '../about/about.view.dart';
import '../home/home.argument.dart';
import '../home/home.view.dart';
import '../league/league.argument.dart';
import '../league/league.view.dart';
import '../record/record.argument.dart';
import '../record/record.view.dart';
import '../shop/shop.argument.dart';
import '../shop/shop.view.dart';
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
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationAppBar(),
    );
  }

  Widget? _buildBody() {
    return switch (ref.read(landingController.notifier).currentItem) {
      LandingItemType.about => AboutView(
          arguments: AboutArgument(title: 'About Title'),
        ),
      LandingItemType.home => HomeView(
          arguments: HomeArgument(title: 'Home Title'),
        ),
      LandingItemType.league => LeagueView(
          arguments: LeagueArgument(title: 'League Title'),
        ),
      LandingItemType.record => RecordView(
          arguments: RecordArgument(title: 'Record Title'),
        ),
      LandingItemType.shop => ShopView(
          arguments: ShopArgument(title: 'Shop Title'),
        ),
    };
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      shape: const CircleBorder(
          side: BorderSide(
        width: 2,
        color: Colors.black38,
      )),
      backgroundColor: Colors.green,
      elevation: 2,
      onPressed: () =>
          ref.read(landingController.notifier).onTapFloatingActionButton(),
      tooltip: 'Play',
      child: const Icon(
        Icons.play_arrow_rounded,
        size: 44,
      ),
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
              // svgIcon: AssetConstant.googleIcon,
              icon: Icons.info,
              item: LandingItemType.about,
              onPressed: () => context.showSnackBar('Create your function.'),
            ),
            const Spacer(),
            _bottomNavigationBarItem(
              // svgIcon: AssetConstant.googleIcon,
              icon: Icons.emoji_events,
              item: LandingItemType.record,
              onPressed: () => ref
                  .read(landingController.notifier)
                  .onTapBottomNavigationBar(LandingItemType.record),
            ),
            const Spacer(),
            // const SizedBox(width: 60), // notch
            _bottomNavigationBarItem(
              // svgIcon: AssetConstant.sunCloudIcon,
              icon: Icons.home,
              item: LandingItemType.home,
              onPressed: () => ref
                  .read(landingController.notifier)
                  .onTapBottomNavigationBar(LandingItemType.home),
            ),
            const Spacer(),
            _bottomNavigationBarItem(
              // svgIcon: AssetConstant.sunCloudIcon,
              icon: Icons.group,
              item: LandingItemType.league,
              onPressed: () => ref
                  .read(landingController.notifier)
                  .onTapBottomNavigationBar(LandingItemType.league),
              badge: const Icon(Icons.check, color: Colors.white, size: 5),
            ),
            const Spacer(),
            _bottomNavigationBarItem(
              // svgIcon: AssetConstant.googleIcon,
              icon: Icons.shopping_cart,
              item: LandingItemType.shop,
              onPressed: () => ref
                  .read(landingController.notifier)
                  .onTapBottomNavigationBar(LandingItemType.shop),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBarItem({
    // required String svgIcon,
    required IconData icon,
    required LandingItemType item,
    required void Function()? onPressed,
    Widget? badge,
  }) {
    final isSelected = ref.read(landingController.notifier).currentItem == item;
    return IconButton.outlined(
      icon: Icon(icon),
      color: Colors.white70,
      iconSize: isSelected ? 44 : 33,
      onPressed: onPressed,
    );
    // return textIconButton(
    //   image: svgIcon,
    //   title: item.name,
    //   onPressed: onPressed,
    //   badge: badge,
    // );
  }
}
