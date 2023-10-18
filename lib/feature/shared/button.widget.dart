import 'package:flutter/material.dart';

import '../../config/theme/theme.provider.dart';

/// example with text only:
/// ```
/// Button(
///   buttonText: 'Button Skeleton',
///   disabledColor: Colors.red,
///   buttonColor: Colors.blue,
///   disabledTextColor: Colors.blue,
///   textColor: Colors.white,
///   onPressed: (context) {
///       print('pressed');
///   },
///   onLongPressed: (context) {
///       print('long pressed');
///   },
/// )
/// ```
///
/// example with text and icon:
/// ```
/// Button(
///   buttonText: 'Button Skeleton',
///   disabledColor: Colors.red,
///   buttonColor: Colors.blue,
///   disabledTextColor: Colors.blue,
///   textColor: Colors.white,
///   icon: Icons.add,
///   iconColor: Colors.black,
///   disabledIconColor: Colors.grey,
///   onPressed: (context) {
///       print('pressed');
///   },
///   onLongPressed: (context) {
///       print('long pressed');
///   },
/// )
/// ```
///
/// example with icon only:
/// ```
/// Button.icon(
///   disabledColor: Colors.red,
///   buttonColor: Colors.blue,
///   icon: Icons.add,
///   iconColor: Colors.black,
///   disabledIconColor: Colors.grey,
///   onPressed: (context) {
///       print('pressed');
///   },
///   onLongPressed: (context) {
///       print('long pressed');
///   },
/// )
/// ```

typedef ContextCallback = void Function(BuildContext context);

class Button extends StatelessWidget {
  final String buttonText;
  final Color? buttonTextColor;
  final Color? disabledButtonTextColor;
  final Color buttonColor;
  final Color? disabledButtonColor;
  final Color overlayColor;
  final TextStyle? buttonTextStyle;

  /// Icondata fit into icon widget of size 24x24
  final IconData? icon;
  final Color? iconColor;
  final Color? disabledIconColor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  final bool enableFeedback;

  /// CircularProgressIndicator's color
  final Color? loaderColor;
  final bool? isLoading;
  final ContextCallback? onPressed;
  final ContextCallback? onLongPressed;

  /// optional pro bordSide
  final BorderSide? bordSide;

  const Button({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.overlayColor = theme.color.overlay,
    this.onLongPressed,
    this.disabledButtonColor = Themes.color.grey50,
    this.disabledButtonTextColor = Themes.color.grey500,
    this.buttonTextStyle,
    this.enableFeedback = false,
    this.isLoading = false,
    this.buttonColor = Themes.color.yellow,
    this.buttonTextColor = Themes.color.black,
    this.loaderColor = Themes.color.blue300,
    this.icon,
    this.iconColor,
    this.disabledIconColor,
    this.bordSide,
  });

  /// ButtonSkeleton icon only constructor
  const Button.icon({
    super.key,
    required this.icon,
    this.onPressed,
    this.onLongPressed,
    this.overlayColor = Themes.color.grey500,
    this.enableFeedback = false,
    this.isLoading = false,
    this.buttonColor = Themes.color.grey50,
    this.disabledButtonColor = Themes.color.grey50,
    this.loaderColor = Themes.color.blue300,
    this.iconColor = Themes.color.black,
    this.disabledIconColor,
    this.bordSide,
  })  : buttonText = '',
        buttonTextColor = null,
        disabledButtonTextColor = null,
        buttonTextStyle = null;

  @override
  Widget build(BuildContext context) {
    if (buttonText.isNotEmpty) {
      return TextButton(
        onPressed: onPressed == null ? null : () => onPressed!(context),
        onLongPress:
            onLongPressed == null ? null : () => onLongPressed!(context),
        style: ButtonStyle(
            enableFeedback: enableFeedback,
            overlayColor:
                MaterialStateProperty.all(overlayColor.withOpacity(0.4)),
            backgroundColor: onPressed != null
                ? MaterialStateProperty.all<Color>(buttonColor)
                : MaterialStateProperty.all<Color>(
                    disabledButtonColor ?? Themes.color.grey50),
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  side: bordSide ?? BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppLibConstantValue.buttonBorderRadius),
                  )),
            )),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppLibConstantValue.horizontalPadding,
            vertical: AppLibConstantValue.buttonWithIconVerticalPadding,
          ),
          width: MediaQuery.of(context).size.width,
          height: AppLibConstantValue.buttonSkeletonHeight,
          child: (isLoading ?? false)
              ? Center(
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: loaderColor,
                      strokeWidth: 1,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: SizedBox(
                          width: AppLibConstantValue.buttonIconSize,
                          height: AppLibConstantValue.buttonIconSize,
                          child: isDisabled()
                              ? Icon(
                                  icon,
                                  color: disabledIconColor ??
                                      disabledButtonTextColor,
                                  size: AppLibConstantValue.buttonIconSize,
                                )
                              : Icon(
                                  icon,
                                  color: iconColor ?? buttonTextColor,
                                  size: AppLibConstantValue.buttonIconSize,
                                ),
                        ),
                      ),
                    Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: buttonTextStyle ??
                          RobotoStyle.label500Small.copyWith(
                              color: isDisabled()
                                  ? disabledButtonTextColor ??
                                      ThemeColor.grey500
                                  : buttonTextColor ?? ThemeColor.black),
                    )
                  ],
                ),
        ),
      );
    } else {
      return InkWell(
        enableFeedback: enableFeedback,
        splashColor: Colors.black.withOpacity(0.2),
        onTap: onPressed != null ? () => onPressed!(context) : null,
        onLongPress:
            onLongPressed != null ? () => onLongPressed!(context) : null,
        child: Ink(
          width: AppLibConstantValue.buttonActionSize,
          height: AppLibConstantValue.buttonActionSize,
          padding: EdgeInsets.all(AppLibConstantValue.buttonActionPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(AppLibConstantValue.buttonBorderRadius),
            ),
            color: isDisabled()
                ? disabledButtonColor ?? Themes.color.grey50
                : buttonColor,
          ),
          child: (isLoading ?? false)
              ? Center(
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: loaderColor,
                      strokeWidth: 1,
                    ),
                  ),
                )
              : Icon(
                  icon,
                  size: AppLibConstantValue.buttonIconSize,
                  color: isDisabled()
                      ? disabledIconColor ?? Themes.color.grey300
                      : iconColor,
                ),
        ),
      );
    }
  }

  bool isDisabled() {
    return onPressed == null && onLongPressed == null;
  }
}
