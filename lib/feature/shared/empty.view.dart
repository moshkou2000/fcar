import 'package:flutter/material.dart';
import 'package:fcar_lib/config/constant/value.constant.dart';

import '../../config/theme/theme_font.dart';

@immutable
class EmptyView extends StatelessWidget {
  final Color? color;
  final Widget? illustration;
  final String? title;
  final String? subtitle;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final void Function()? primaryButtonOnPressed;
  final void Function()? secondaryButtonOnPressed;

  const EmptyView({
    this.color,
    this.illustration,
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
    return Container(
      color: color ?? Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    Container(),
                    if (illustration != null)
                      _illustrationWidget(
                          illustration: illustration!,
                          height: constraints.maxHeight != double.infinity
                              ? constraints.maxHeight * 0.4
                              : 200), // resolve the image
                    if (title != null) _titleWidget(title: title!),
                    if (subtitle != null) _subtitleWidget(subtitle: subtitle!),
                    if (primaryButtonText != null)
                      _primaryButtonWidget(text: primaryButtonText!),
                    if (secondaryButtonText != null)
                      _secondaryButtonWidget(text: secondaryButtonText!),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _illustrationWidget({
    required Widget illustration,
    required double height,
  }) {
    return Container(
      height: height,
      alignment: Alignment.bottomCenter,
      child: illustration,
    );
  }

  Widget _titleWidget({required String title}) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
          onPressed: primaryButtonOnPressed,
          child: Text(text),
        ),
      ),
    );
  }

  Widget _secondaryButtonWidget({required String text}) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: TextButton(
        onPressed: secondaryButtonOnPressed,
        child: Text(text),
      ),
    );
  }
}
