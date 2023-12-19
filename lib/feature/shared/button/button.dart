import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/theme_color.dart';
import '../../../config/theme/theme_font.dart';
import 'button.enum.dart';
import 'button_observer.dart';

/// [buttonType] is required.
///
/// [onPressed] is required.
///
/// The order of the elements from top to bottom is ->
///   [icon]
///   [title]
///   [subtitle]
///
/// default [titleBold] is [true]
/// default [subtitleBold] is [false]
/// default [alignment] is [CrossAxisAlignment.start]
/// default [color] is [ThemeColor.black]
///   it applies to all [icon] & [title] & [subtitle] & [overlayColor]
/// default [width] is [double.infinity]
/// default [buttonState] is ButtonState.idle
///
/// [title] & [subtitle] are case sensitive
/// title is in bold style be default [titleBold] is true
///   set the default [title] & [subtitle] bold style
///
/// [observer] is to change the [MaterialState] of the [OutlinedButton]
///
class ObserverButton extends StatefulWidget {
  final ButtonType buttonType;
  final void Function(ButtonObserver buttonState) onPressed;
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final Widget? child;
  final double? width;
  final bool? titleBold;
  final bool? subtitleBold;
  final Color? color;
  final Color? colorDisabled;
  final CrossAxisAlignment? alignment;
  final ButtonState? buttonState;

  const ObserverButton({
    required this.buttonType,
    required this.onPressed,
    this.icon,
    this.title,
    this.subtitle,
    this.child,
    this.width,
    this.titleBold = true,
    this.subtitleBold = false,
    this.color = Colors.black,
    this.colorDisabled = Colors.grey,
    this.alignment = CrossAxisAlignment.start,
    this.buttonState = ButtonState.idle,
    super.key,
  });

  @override
  State<ObserverButton> createState() => _ObserverButtonState();
}

class _ObserverButtonState extends State<ObserverButton> {
  late final ButtonObserver _observer;

  @override
  void initState() {
    _observer = ButtonObserver();
    super.initState();
  }

  @override
  void dispose() {
    _observer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => switch (widget.buttonType) {
        ButtonType.outlinedButton => ValueListenableBuilder<ButtonState>(
            valueListenable: _observer,
            builder: (_, state, __) => outlinedButton(
              onPressed: state == widget.buttonState
                  ? () => widget.onPressed(_observer)
                  : null,
              icon: widget.icon,
              title: widget.title,
              subtitle: widget.subtitle,
              width: widget.width,
              child: widget.child,
              color: widget.color!,
              colorDisabled: widget.colorDisabled!,
              titleBold: widget.titleBold!,
              subtitleBold: widget.subtitleBold!,
              alignment: widget.alignment!,
            ),
          ),
        ButtonType.textButton => ValueListenableBuilder<ButtonState>(
            valueListenable: _observer,
            builder: (_, state, __) => textButton(
              onPressed: state == widget.buttonState
                  ? () => widget.onPressed(_observer)
                  : null,
              icon: widget.icon,
              title: widget.title,
              subtitle: widget.subtitle,
              width: widget.width,
              child: widget.child,
              color: widget.color!,
              colorDisabled: widget.colorDisabled!,
              titleBold: widget.titleBold!,
              subtitleBold: widget.subtitleBold!,
              alignment: widget.alignment!,
            ),
          )
      };
}

Widget textIconButton({
  required String image,
  required String title,
  required void Function()? onPressed,
  Widget? badge,
}) {
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: 0, end: 0),
    showBadge: badge != null,
    ignorePointer: false,
    onTap: () {},
    badgeContent: badge,
    badgeAnimation: const badges.BadgeAnimation.rotation(
      animationDuration: Duration(seconds: 1),
      colorChangeAnimationDuration: Duration(seconds: 1),
      loopAnimation: false,
      curve: Curves.fastOutSlowIn,
      colorChangeAnimationCurve: Curves.easeInCubic,
    ),
    badgeStyle: badges.BadgeStyle(
      shape: badges.BadgeShape.square,
      badgeColor: Colors.blue,
      padding: const EdgeInsets.all(5),
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.white, width: 1),
      elevation: 0,
    ),
    child: GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              image,
              height: 40,
              width: 40,
            ),
            Text(
              title,
              style: ThemeFont.subtitleStyle.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget outlinedButton({
  required void Function()? onPressed,
  IconData? icon,
  String? title,
  String? subtitle,
  double? width,
  Widget? child,
  Color color = Colors.black,
  Color colorDisabled = Colors.grey,
  bool titleBold = true,
  bool subtitleBold = false,
  CrossAxisAlignment alignment = CrossAxisAlignment.start,
}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      fixedSize: width != null
          ? MaterialStateProperty.all<Size?>(Size.fromWidth(width))
          : null,
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide(
              width: 2,
              color: colorDisabled,
            );
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.hovered)) {
            return BorderSide(
              width: 2,
              color: color,
            );
          }

          return BorderSide(
            width: 2,
            color: color.withOpacity(0.4),
          ); // Defer to the widget's default.
        },
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return color.withOpacity(.2);
          }

          return null; // Defer to the widget's default.
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return color.withOpacity(0.1);
          }
          if (states.contains(MaterialState.hovered)) {
            return color.withOpacity(0.04);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            return color.withOpacity(0.12);
          }
          return null; // Defer to the widget's default.
        },
      ),
    ),
    child: SizedBox(
      width: width,
      child: child ??
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: alignment,
            children: [
              const SizedBox(),
              if (icon != null)
                Icon(
                  icon,
                  color: color,
                ),
              if (title != null)
                Text(
                  title,
                  style: titleBold
                      ? ThemeFont.titleStyle.copyWith(color: color)
                      : ThemeFont.subtitleStyle.copyWith(color: colorDisabled),
                ),
              if (title != null && subtitle != null) const SizedBox(height: 8),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: subtitleBold
                      ? ThemeFont.titleStyle.copyWith(color: color)
                      : ThemeFont.subtitleStyle.copyWith(color: colorDisabled),
                  maxLines: 4,
                ),
            ],
          ),
    ),
  );
}

Widget textButton({
  required void Function()? onPressed,
  IconData? icon,
  String? title,
  String? subtitle,
  double? width,
  Widget? child,
  Color color = Colors.black,
  Color colorDisabled = Colors.grey,
  bool titleBold = true,
  bool subtitleBold = false,
  CrossAxisAlignment alignment = CrossAxisAlignment.start,
}) {
  return TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      fixedSize: width != null
          ? MaterialStateProperty.all<Size?>(Size.fromWidth(width))
          : null,
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return color.withOpacity(0.1);
          }
          return Colors.transparent; // Defer to the widget's default.
        },
      ),
    ),
    child: SizedBox(
      width: width,
      child: child ??
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              if (icon != null)
                Icon(
                  icon,
                  color: color,
                ),
              if (title != null)
                Text(
                  title,
                  style: titleBold
                      ? ThemeFont.titleStyle.copyWith(color: color)
                      : ThemeFont.subtitleStyle.copyWith(color: colorDisabled),
                ),
              if (title != null && subtitle != null) const SizedBox(height: 8),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: subtitleBold
                      ? ThemeFont.titleStyle.copyWith(color: color)
                      : ThemeFont.subtitleStyle.copyWith(color: colorDisabled),
                  maxLines: 4,
                ),
            ],
          ),
    ),
  );
}


// import 'package:flutter/material.dart';
// import '../../../config/theme/theme.module.dart';
// /// example with text only:
// /// ```
// /// Button(
// ///   buttonText: 'Button Skeleton',
// ///   disabledColor: Colors.red,
// ///   buttonColor: Colors.blue,
// ///   disabledTextColor: Colors.blue,
// ///   textColor: Colors.white,
// ///   onPressed: (context) {
// ///       print('pressed');
// ///   },
// ///   onLongPressed: (context) {
// ///       print('long pressed');
// ///   },
// /// )
// /// ```
// ///
// /// example with text and icon:
// /// ```
// /// Button(
// ///   buttonText: 'Button Skeleton',
// ///   disabledColor: Colors.red,
// ///   buttonColor: Colors.blue,
// ///   disabledTextColor: Colors.blue,
// ///   textColor: Colors.white,
// ///   icon: Icons.add,
// ///   iconColor: Colors.black,
// ///   disabledIconColor: Colors.grey,
// ///   onPressed: (context) {
// ///       print('pressed');
// ///   },
// ///   onLongPressed: (context) {
// ///       print('long pressed');
// ///   },
// /// )
// /// ```
// ///
// /// example with icon only:
// /// ```
// /// Button.icon(
// ///   disabledColor: Colors.red,
// ///   buttonColor: Colors.blue,
// ///   icon: Icons.add,
// ///   iconColor: Colors.black,
// ///   disabledIconColor: Colors.grey,
// ///   onPressed: (context) {
// ///       print('pressed');
// ///   },
// ///   onLongPressed: (context) {
// ///       print('long pressed');
// ///   },
// /// )
// /// ```
// typedef ContextCallback = void Function(BuildContext context);
// class Button extends StatelessWidget {
//   final String buttonText;
//   final Color? buttonTextColor;
//   final Color? disabledButtonTextColor;
//   final Color buttonColor;
//   final Color? disabledButtonColor;
//   final Color overlayColor;
//   final TextStyle? buttonTextStyle;
//   /// Icondata fit into icon widget of size 24x24
//   final IconData? icon;
//   final Color? iconColor;
//   final Color? disabledIconColor;
//   /// Whether detected gestures should provide acoustic and/or haptic feedback.
//   final bool enableFeedback;
//   /// CircularProgressIndicator's color
//   final Color? loaderColor;
//   final bool? isLoading;
//   final ContextCallback? onPressed;
//   final ContextCallback? onLongPressed;
//   /// optional pro bordSide
//   final BorderSide? bordSide;
//   const Button({
//     super.key,
//     required this.buttonText,
//     this.onPressed,
//     this.overlayColor = ThemeColor.overlay,
//     this.onLongPressed,
//     this.disabledButtonColor = ThemeColor.grey50,
//     this.disabledButtonTextColor = ThemeColor.grey500,
//     this.buttonTextStyle,
//     this.enableFeedback = false,
//     this.isLoading = false,
//     this.buttonColor = ThemeColor.yellow,
//     this.buttonTextColor = ThemeColor.black,
//     this.loaderColor = ThemeColor.blue300,
//     this.icon,
//     this.iconColor,
//     this.disabledIconColor,
//     this.bordSide,
//   });
//   /// ButtonSkeleton icon only constructor
//   const Button.icon({
//     super.key,
//     required this.icon,
//     this.onPressed,
//     this.onLongPressed,
//     this.overlayColor = ThemeColor.grey500,
//     this.enableFeedback = false,
//     this.isLoading = false,
//     this.buttonColor = ThemeColor.grey50,
//     this.disabledButtonColor = ThemeColor.grey50,
//     this.loaderColor = ThemeColor.blue300,
//     this.iconColor = ThemeColor.black,
//     this.disabledIconColor,
//     this.bordSide,
//   })  : buttonText = '',
//         buttonTextColor = null,
//         disabledButtonTextColor = null,
//         buttonTextStyle = null;
//   @override
//   Widget build(BuildContext context) {
//     if (buttonText.isNotEmpty) {
//       return TextButton(
//         onPressed: onPressed == null ? null : () => onPressed!(context),
//         onLongPress:
//             onLongPressed == null ? null : () => onLongPressed!(context),
//         style: ButtonStyle(
//             enableFeedback: enableFeedback,
//             overlayColor:
//                 MaterialStateProperty.all(overlayColor.withOpacity(0.4)),
//             backgroundColor: onPressed != null
//                 ? MaterialStateProperty.all<Color>(buttonColor)
//                 : MaterialStateProperty.all<Color>(
//                     disabledButtonColor ?? ThemeColor.grey50),
//             padding:
//                 MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                   side: bordSide ?? BorderSide.none,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(AppLibConstantValue.buttonBorderRadius),
//                   )),
//             )),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: AppLibConstantValue.horizontalPadding,
//             vertical: AppLibConstantValue.buttonWithIconVerticalPadding,
//           ),
//           width: MediaQuery.of(context).size.width,
//           height: AppLibConstantValue.buttonSkeletonHeight,
//           child: (isLoading ?? false)
//               ? Center(
//                   child: SizedBox(
//                     width: 15,
//                     height: 15,
//                     child: CircularProgressIndicator(
//                       color: loaderColor,
//                       strokeWidth: 1,
//                     ),
//                   ),
//                 )
//               : Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     if (icon != null)
//                       Padding(
//                         padding: const EdgeInsets.only(right: 4),
//                         child: SizedBox(
//                           width: AppLibConstantValue.buttonIconSize,
//                           height: AppLibConstantValue.buttonIconSize,
//                           child: isDisabled()
//                               ? Icon(
//                                   icon,
//                                   color: disabledIconColor ??
//                                       disabledButtonTextColor,
//                                   size: AppLibConstantValue.buttonIconSize,
//                                 )
//                               : Icon(
//                                   icon,
//                                   color: iconColor ?? buttonTextColor,
//                                   size: AppLibConstantValue.buttonIconSize,
//                                 ),
//                         ),
//                       ),
//                     Text(
//                       buttonText,
//                       textAlign: TextAlign.center,
//                       style: buttonTextStyle ??
//                           RobotoStyle.label500Small.copyWith(
//                               color: isDisabled()
//                                   ? disabledButtonTextColor ??
//                                       ThemeColor.grey500
//                                   : buttonTextColor ?? ThemeColor.black),
//                     )
//                   ],
//                 ),
//         ),
//       );
//     } else {
//       return InkWell(
//         enableFeedback: enableFeedback,
//         splashColor: Colors.black.withOpacity(0.2),
//         onTap: onPressed != null ? () => onPressed!(context) : null,
//         onLongPress:
//             onLongPressed != null ? () => onLongPressed!(context) : null,
//         child: Ink(
//           width: AppLibConstantValue.buttonActionSize,
//           height: AppLibConstantValue.buttonActionSize,
//           padding: EdgeInsets.all(AppLibConstantValue.buttonActionPadding),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(AppLibConstantValue.buttonBorderRadius),
//             ),
//             color: isDisabled()
//                 ? disabledButtonColor ?? ThemeColor.grey50
//                 : buttonColor,
//           ),
//           child: (isLoading ?? false)
//               ? Center(
//                   child: SizedBox(
//                     width: 15,
//                     height: 15,
//                     child: CircularProgressIndicator(
//                       color: loaderColor,
//                       strokeWidth: 1,
//                     ),
//                   ),
//                 )
//               : Icon(
//                   icon,
//                   size: AppLibConstantValue.buttonIconSize,
//                   color: isDisabled()
//                       ? disabledIconColor ?? ThemeColor.grey300
//                       : iconColor,
//                 ),
//         ),
//       );
//     }
//   }
//   bool isDisabled() {
//     return onPressed == null && onLongPressed == null;
//   }
// }
