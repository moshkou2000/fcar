import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fcar_lib/config/extension/string.extension.dart';

import '../../config/constant/asset.constant.dart';
import '../../core/service/localization/localization.dart';
import '../../core/service/navigation/navigation_route.dart';
import '../shared/shared.module.dart';
import 'home.argument.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.arguments, super.key});

  final HomeArgument arguments;

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return EmptyView(
      illustration: SvgPicture.asset(
        AssetConstant.emptyStates,
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        width: 200,
      ),
      title: widget.arguments.title.titleCase,
      subtitle:
          'localization.noInternet.titleCase localization.noInternet.titleCase localizations ',
      primaryButtonText: Localization.ok.titleCase,
      secondaryButtonText: Localization.cancel.titleCase,
      primaryButtonOnPressed: () =>
          Navigation.navigateTo(NavigationRoute.ecommerceRoute),
    );
  }
}
