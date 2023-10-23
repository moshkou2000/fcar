import '../../config/constant/asset.constant.dart';
import '../../core/extension/string.extension.dart';
import '../../core/service/localization/localization.provider.dart';
import 'home.argument.dart';
import 'package:flutter/material.dart';

import '../shared/empty.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.arguments, super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final HomeArgument arguments;

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return EmptyView(
      elastration: Image.asset(
        AssetConstant.calendarImage,
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
      ),
      title: widget.arguments.title.titleCase,
      subtitle:
          'localization.noInternet.titleCase localization.noInternet.titleCase localizations ',
      primaryButtonText: localization.ok.titleCase,
      secondaryButtonText: localization.cancel.titleCase,
    );
  }
}
