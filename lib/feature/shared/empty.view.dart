import 'package:flutter/material.dart';

import '../../config/theme/font_style.module.dart';

class EmptyView extends StatelessWidget {
  final Widget? elastration;
  final String? title;
  final String? subtitle;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final Function()? primaryButtonOnPressed;
  final Function()? secondaryButtonOnPressed;

  const EmptyView({
    this.elastration,
    this.title,
    this.subtitle,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.primaryButtonOnPressed,
    this.secondaryButtonOnPressed,
    Key? key,
  }) : super(key: key);

  Widget get _elastrationWidget => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: elastration,
      );

  Widget get _titleWidget => Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          title!,
          style: ThemeFont.titleStyle,
          textAlign: TextAlign.center,
        ),
      );

  Widget get _subtitleWidget => Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          title!,
          style: ThemeFont.subtitleStyle,
          textAlign: TextAlign.center,
        ),
      );

  Widget get _primaryButtonWidget => ElevatedButton(
        child: Text(primaryButtonText!),
        onPressed: () => {},
      );

  Widget get _secondaryButtonWidget => TextButton(
        child: Text(secondaryButtonText!),
        onPressed: () => {},
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (elastration != null) _elastrationWidget,
          if (title != null) _titleWidget,
          if (subtitle != null) _subtitleWidget,
          if (primaryButtonText != null) _primaryButtonWidget,
          if (secondaryButtonText != null) _secondaryButtonWidget,
        ],
      ),
    );
  }
}
