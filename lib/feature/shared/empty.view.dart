import 'package:flutter/material.dart';

import '../../config/constant/value.constant.dart';
import '../../config/theme/color.module.dart';
import '../../config/theme/font_style.module.dart';

@immutable
class EmptyView extends StatelessWidget {
  final Image? elastration;
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(),
                  if (elastration != null)
                    _elastrationWidget(
                        elastration: elastration!,
                        height: constraints.maxHeight / 2),
                  if (title != null) _titleWidget(title: title!),
                  if (subtitle != null) _subtitleWidget(subtitle: subtitle!),
                  if (primaryButtonText != null)
                    _primaryButtonWidget(text: primaryButtonText!),
                  if (secondaryButtonText != null)
                    _secondaryButtonWidget(text: secondaryButtonText!),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _elastrationWidget({
    required Image elastration,
    required double height,
  }) {
    return Container(
      color: ThemeColor.background,
      height: height,
      child: elastration,
    );
  }

  Widget _titleWidget({required String title}) {
    return Container(
      margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Text(
        title,
        style: ThemeFont.titleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _subtitleWidget({required String subtitle}) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Text(
        subtitle,
        style: ThemeFont.subtitleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _primaryButtonWidget({required String text}) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(minWidth: ValueConstant.minButtonWidth),
        child: ElevatedButton(
          child: Text(text),
          onPressed: () => {},
        ),
      ),
    );
  }

  Widget _secondaryButtonWidget({required String text}) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: TextButton(
        child: Text(text),
        onPressed: () => {},
      ),
    );
  }
}
