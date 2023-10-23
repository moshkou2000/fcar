import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/color/korra_color.dart';
import '../../../config/theme/font/roboto_style.dart';
import '../../../core/service/localization/localization.provider.dart';
import '../../../core/service/navigation.service.dart';
import 'dialog.enum.dart';
import 'dialog_observer.dart';

typedef DialogObserverCallback = void Function(DialogObserver);

const int _dialogEaseInDuration = 200;
const int _dialogEaseOutDuration = 250;
const AlignmentGeometry _defaultPosition = Alignment.bottomCenter;

/// primaryActionText: localization.ok
/// action: Future<dynamic> or void function()
///   default: navigationService.pop();
///
void showErrorDialog({
  String? title,
  String? subtitle,
  String? primaryActionText,
  FutureOr? action,
  AlignmentGeometry position = _defaultPosition,
}) {
  final context = navigationService.context;
  if (context != null) {
    showDialogAt(
        context: context,
        position: position,
        title: title,
        subtitle: subtitle,
        barrierDismissible: false,
        primaryActionText: primaryActionText ?? localization.ok,
        onPrimaryActionPressed: (observer) async {
          observer.showLoading();
          if (action != null) {
            if (action is Future<dynamic>) {
              await action;
            } else {
              action.call();
            }
          }
          navigationService.pop();
          observer.hideLoading();
        });
  }
}

/// to set posittion of the dialog,
/// bottomSheetDialog position is at the center bottom
void showDialogAt({
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
}) {
  showModal<void>(
    context: context,
    configuration: FadeScaleTransitionConfiguration(
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        transitionDuration: openDialogTransitionDuration ??
            const Duration(milliseconds: _dialogEaseInDuration),
        reverseTransitionDuration: closeDialogTransitionDuration),
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: _PositionedDialog(
          position: position,
          title: title,
          titleStyle: titleStyle,
          subtitle: subtitle,
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
  _PositionedDialogState createState() => _PositionedDialogState();
}

class _PositionedDialogState extends State<_PositionedDialog> {
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
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
              _buildActionButtons(),
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
              style: ThemeFont.titleStyle.copyWith(color: Colors.grey),
              children: widget.subtitleChildren),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        /// secondary action button
        Visibility(
          visible: widget.secondaryActionText?.isNotEmpty == true,
          replacement: const SizedBox.shrink(),
          child: Expanded(
            child: ValueListenableBuilder<DialogState>(
              valueListenable: _dialogStateObserver,
              builder: (context, dialogState, child) {
                return FilledButton(
                  onPressed: dialogState == DialogState.loading
                      ? null
                      : () {
                          if (widget.onPrimaryActionPressed != null) {
                            widget
                                .onPrimaryActionPressed!(_dialogStateObserver);
                          }
                        },
                  child: dialogState != DialogState.loading
                      ? Text(
                          widget.secondaryActionText ?? '',
                          textAlign: TextAlign.center,
                          style: ThemeFont.titleStyle.copyWith(
                              color: widget.secondaryActionTextColor ??
                                  Colors.white),
                        )
                      : _buildActionButtonLoading(),
                );
              },
            ),
          ),
        ),

        Visibility(
          visible: widget.secondaryActionText?.isNotEmpty == true,
          replacement: const SizedBox.shrink(),
          child: const SizedBox(width: 16),
        ),

        /// primary action button
        Expanded(
          child: ValueListenableBuilder<DialogState>(
            valueListenable: _dialogStateObserver,
            builder: (context, dialogState, child) {
              return FilledButton(
                onPressed: dialogState == DialogState.loading
                    ? null
                    : () {
                        if (widget.onPrimaryActionPressed != null) {
                          widget.onPrimaryActionPressed!(_dialogStateObserver);
                        }
                      },
                child: dialogState != DialogState.loading
                    ? Text(
                        widget.primaryActionText ?? '',
                        textAlign: TextAlign.center,
                        style: ThemeFont.titleStyle.copyWith(
                            color:
                                widget.primaryActionTextColor ?? Colors.white),
                      )
                    : _buildActionButtonLoading(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtonLoading() {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 1,
        backgroundColor: ThemeColor.inversePrimary,
        valueColor: AlwaysStoppedAnimation<Color>(ThemeColor.primary),
      ),
    );
  }
}
