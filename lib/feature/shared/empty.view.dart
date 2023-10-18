import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../config/theme/theme.provider.dart';
import 'button.widget.dart';

class EmptyView extends StatelessWidget {
  final Widget elastration;
  final String title;
  final String subtitle;
  final String primaryButtonText;
  final String secondaryButtonText;

  const EmptyView({
    required this.elastration,
    required this.title,
    required this.subtitle,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    Key? key,
  }) : super(key: key);

  Widget get _elastrationWidget => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: elastration,
      );

  Widget get _titleWidget => Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          title,
          style: theme.titleStyle,
        ),
      );

  Widget get _subtitleWidget => Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.subtitleStyle,
        ),
      );

  Widget get _primaryButtonWidget => Button(
        buttonText: primaryButtonText,
        buttonTextColor: theme.color.,
        buttonColor: Themes.color.yellow,
        disabledButtonColor: Themes.color.yellow.withOpacity(0.5),
        onPressed: (context) => {},
      );

  Widget get _secondaryButtonWidget => Button(
        buttonText: secondaryButtonText,
        buttonTextColor: Themes.color.black,
        buttonColor: Themes.color.yellow,
        disabledButtonColor: Themes.color.yellow.withOpacity(0.5),
        onPressed: (context) => {},
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _elastrationWidget,
          _titleWidget,
          _subtitleWidget,
          _primaryButtonWidget,
          _secondaryButtonWidget,
        ],
      ),
    );
  }
}
