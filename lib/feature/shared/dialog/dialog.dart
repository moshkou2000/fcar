import 'dart:async';

import 'package:animations/animations.dart';
import 'package:fcar_lib/config/extension/string.extension.dart';
import 'package:fcar_lib/core/datasource/network/network_exception.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/theme_color.dart';
import '../../../config/theme/theme_font.dart';
import '../../../core/service/localization/localization.dart';
import '../shared.module.dart';

typedef DialogObserverCallback = void Function(ButtonObserver);

const int _dialogEaseInDuration = 200;
const int _dialogEaseOutDuration = 250;
const AlignmentGeometry _defaultPosition = Alignment.bottomCenter;

/// Shows a dialog and resolves to true when the user has indicated that they
/// want to pop.
///
/// A return value of null indicates a desire not to pop, such as when the
/// user has dismissed the modal without tapping a button.
Future<bool?> showBackDialog() async {
  final context = Navigation.context;
  if (context != null) {
    return await showDialogAt<bool>(
      context: context,
      title: Localization.exit,
      subtitle: Localization.exitDescription,
      barrierDismissible: false,
      primaryActionText: Localization.exit,
      secondaryActionText: Localization.cancel,
      onPrimaryActionPressed: (observer) async {
        observer.setLoading();
        Navigator.pop(context, true);
        observer.setIdle();
      },
      onSecondaryActionPressed: (observer) async {
        observer.setLoading();
        Navigator.pop(context, false);
        observer.setIdle();
      },
    );
  }

  return Future.value(null);
}

/// primaryActionText: localization.ok
/// action: Future<dynamic> or void function()
///   default: navigationService.pop();
///
void showErrorDialog({
  dynamic error,
  dynamic stacktrace,
  String? title,
  String? subtitle,
  String? primaryActionText,
  FutureOr? action,
  AlignmentGeometry position = _defaultPosition,
}) {
  final context = Navigation.context;
  if (context != null) {
    final t = title ?? (error is NetworkException ? error.title : null);
    final s = subtitle ??
        (error is NetworkException ? error.message : null) ??
        error.toString();
    showDialogAt(
        context: context,
        position: position,
        title: t?.titleCase,
        subtitle: s.titleCase,
        barrierDismissible: false,
        primaryActionText: primaryActionText ?? Localization.ok,
        onPrimaryActionPressed: (observer) async {
          observer.setLoading();
          if (action != null) {
            if (action is Future<dynamic>) {
              await action;
            } else {
              action.call();
            }
          }
          Navigation.pop();
          observer.setIdle();
        });
  }
}

/// to set posittion of the dialog,
/// bottomSheetDialog position is at the center bottom
Future<T?> showDialogAt<T>({
  required BuildContext context,

  /// to set posittion of the dialog,
  /// bottomSheetDialog position is at the center bottom
  AlignmentGeometry position = _defaultPosition,

  /// dismissible when user click at dialog scrim
  bool barrierDismissible = true,

  /// dialog scrim color
  Color barrierColor = Colors.black54,

  /// animation duration FadeScale when show the dialog
  Duration? openDialogTransitionDuration,

  /// animation duration FadeScale when close the dialog
  Duration closeDialogTransitionDuration =
      const Duration(milliseconds: _dialogEaseOutDuration),

  /// loading indicator background color
  Color? circularLoaderBackgroundColor,

  /// loading indicator value color
  Color? circularArcColor,
  String? primaryActionText,
  String? title,
  TextStyle? titleStyle,
  String? subtitle,
  List<InlineSpan>? subtitleChildren,
  TextStyle? subtitleStyle,
  String? secondaryActionText,
  Widget? illustration,
  DialogObserverCallback? onPrimaryActionPressed,
  DialogObserverCallback? onSecondaryActionPressed,
  Color? primaryActionColor,
  Color? primaryActionTextColor,
  Color? secondaryActionColor,
  Color? secondaryActionTextColor,
}) async {
  return await showModal<T>(
    context: context,
    configuration: FadeScaleTransitionConfiguration(
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        transitionDuration: openDialogTransitionDuration ??
            const Duration(milliseconds: _dialogEaseInDuration),
        reverseTransitionDuration: closeDialogTransitionDuration),
    builder: (BuildContext context) {
      return PopScope(
        canPop: barrierDismissible,
        child: _PositionedDialog(
          position: position,
          title: title?.titleCase,
          titleStyle: titleStyle,
          subtitle: subtitle?.titleCase,
          subtitleChildren: subtitleChildren,
          subtitleStyle: subtitleStyle,
          primaryActionText: primaryActionText,
          secondaryActionText: secondaryActionText,
          illustration: illustration,
          onPrimaryActionPressed: onPrimaryActionPressed,
          onSecondaryActionPressed: onSecondaryActionPressed,
          primaryActionColor: primaryActionColor,
          primaryActionTextColor: primaryActionTextColor,
          secondaryActionColor: secondaryActionColor,
          secondaryActionTextColor: secondaryActionTextColor,
          circularBackgroundLoadingIndicatorColor:
              circularLoaderBackgroundColor,
        ),
      );
    },
  );
}

class _PositionedDialog extends StatefulWidget {
  /// to set posittion of the dialog,
  /// bottomSheetDialog position is at the center bottom
  final AlignmentGeometry position;

  /// dialog header title
  final String? title;

  /// dialog header title style
  final TextStyle? titleStyle;

  /// sub message
  final String? subtitle;

  /// sub message with different text style
  final List<InlineSpan>? subtitleChildren;

  /// sub message text style
  final TextStyle? subtitleStyle;

  /// primary CTA button text (right)
  final String? primaryActionText;

  /// secondary CTA button text (left)
  final String? secondaryActionText;

  /// will fixed [illustration] to 72x64
  final Widget? illustration;

  /// primary CTA button callback (right)
  final DialogObserverCallback? onPrimaryActionPressed;

  /// secondary CTA button callback (left)
  final DialogObserverCallback? onSecondaryActionPressed;

  /// primary CTA button background color (right)
  final Color? primaryActionColor;

  /// primary CTA button text color (right)
  final Color? primaryActionTextColor;

  //  secondary CTA button background color (left)
  final Color? secondaryActionColor;

  /// secondary CTA button text color (left)
  final Color? secondaryActionTextColor;

  /// circular background color for [CircularProgressIndicator]
  final Color? circularBackgroundLoadingIndicatorColor;

  const _PositionedDialog({
    required this.position,
    this.subtitleChildren,
    this.subtitleStyle,
    this.secondaryActionColor,
    this.secondaryActionTextColor,
    this.circularBackgroundLoadingIndicatorColor,
    this.primaryActionTextColor,
    this.primaryActionColor,
    this.illustration,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.primaryActionText,
    this.secondaryActionText,
    this.onPrimaryActionPressed,
    this.onSecondaryActionPressed,
  });

  @override
  _Positionedbool createState() => _Positionedbool();
}

class _Positionedbool extends State<_PositionedDialog> {
  late final DialogObserver _dialogStateObserver;

  @override
  void initState() {
    _dialogStateObserver = DialogObserver();
    super.initState();
  }

  @override
  void dispose() {
    _dialogStateObserver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.position,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIllustration(),
              _buildTitle(),
              _buildSubtitle(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Visibility(
      maintainState: false,
      maintainSize: false,
      visible: widget.illustration != null,
      replacement: const SizedBox.shrink(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: 72,
          height: 64,
          child: widget.illustration,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Visibility(
      visible: widget.title != null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          widget.title ?? '',
          style: ThemeFont.titleStyle.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Visibility(
      visible: widget.subtitle != null || widget.subtitleChildren != null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: RichText(
          text: TextSpan(
              text: widget.subtitle ?? '',
              style: ThemeFont.subtitleStyle.copyWith(color: Colors.grey),
              children: widget.subtitleChildren),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        /// primary button
        Visibility(
          visible: widget.primaryActionText?.isNotEmpty == true,
          replacement: const SizedBox.shrink(),
          child: Expanded(
            child: _buildPrimaryButton(),
          ),
        ),

        Visibility(
          visible: widget.secondaryActionText?.isNotEmpty == true,
          replacement: const SizedBox.shrink(),
          child: const SizedBox(width: 16),
        ),

        /// secondary button
        Visibility(
          visible: widget.secondaryActionText?.isNotEmpty == true,
          replacement: const SizedBox.shrink(),
          child: Expanded(
            child: _buildSecondaryButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    return ObserverButton(
      buttonType: ButtonType.outlinedButton,
      onPressed: (observer) {
        if (widget.onPrimaryActionPressed != null) {
          observer.setLoading();
          widget.onPrimaryActionPressed!(observer);
          observer.setIdle();
        }
      },
      width: double.infinity,
      title: widget.primaryActionText,
      color: ThemeColor.error,
      alignment: CrossAxisAlignment.center,
    );
  }

  Widget _buildSecondaryButton() {
    return ObserverButton(
      buttonType: ButtonType.textButton,
      onPressed: (observer) {
        if (widget.onSecondaryActionPressed != null) {
          observer.setLoading();
          widget.onSecondaryActionPressed!(observer);
          observer.setIdle();
        }
      },
      width: double.infinity,
      title: widget.secondaryActionText,
      color: ThemeColor.button,
      alignment: CrossAxisAlignment.center,
    );
  }
}
