import 'package:fcar_lib/config/extension/string.extension.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constant/asset.constant.dart';
import 'empty.view.dart';

@immutable
class UnimplementedView extends StatelessWidget {
  final String title;
  const UnimplementedView({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyView(
      illustration: SvgPicture.asset(
        AssetConstant.informational,
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        width: 200,
      ),
      title: title.titleCase,
      primaryButtonOnPressed: () => Navigation.pop(),
    );
  }
}
