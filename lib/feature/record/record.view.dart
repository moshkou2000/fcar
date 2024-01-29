import 'package:fcar_lib/config/extension/string.extension.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constant/asset.constant.dart';
import '../../core/service/localization/localization.dart';
import '../../core/service/navigation/navigation_route.dart';
import '../shared/shared.module.dart';
import 'record.argument.dart';

class RecordView extends StatefulWidget {
  const RecordView({required this.arguments, super.key});

  final RecordArgument arguments;

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
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
