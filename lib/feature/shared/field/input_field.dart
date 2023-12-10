import 'package:flutter/material.dart';

/// Example
///
/// inputField(
///   labelText: 'Email',
///   keyboardType: TextInputType.emailAddress,
///   textInputAction: TextInputAction.next,
///   autovalidateMode: AutovalidateMode.onUserInteraction,
///   onChanged: (value) => setState(() => _username = value),
///   validator: (value) =>
///     value?.isNotEmpty == true && value?.isValidEmail != true
///       ? 'Enter a valid email.' : null,),
///
TextFormField inputField({
  Key? key,
  TextEditingController? controller,
  String? initialValue,
  String? labelText,
  void Function(String)? onChanged,
  void Function(String?)? onSubmitted,
  String? Function(String?)? validator,
  String? errorText,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  FocusNode? focusNode,
  bool autoFocus = false,
  bool obscureText = false,
  Color color = Colors.black,
  Color colorDisabled = Colors.grey,
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return TextFormField(
    key: key,
    controller: controller,
    initialValue: initialValue,
    autovalidateMode: autovalidateMode,
    focusNode: focusNode,
    autofocus: autoFocus,
    onChanged: onChanged,
    onSaved: onSubmitted,
    validator: validator,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    obscureText: obscureText,
    style: MaterialStateTextStyle.resolveWith(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(color: colorDisabled);
        }
        return const TextStyle(color: Colors.blue);
      },
    ),
    decoration: InputDecoration(
      labelText: labelText,
      errorText: errorText,
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return TextStyle(color: colorDisabled);
          }
          // if (states.contains(MaterialState.error)) {
          //   return const TextStyle(color: ThemeColor.error);
          // }
          return TextStyle(color: color);
        },
      ),
      labelStyle: MaterialStateTextStyle.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return TextStyle(color: colorDisabled);
          }
          // if (states.contains(MaterialState.error)) {
          //   return const TextStyle(color: ThemeColor.error);
          // }
          return TextStyle(color: color.withOpacity(0.6));
        },
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 2, color: color.withOpacity(0.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 2, color: color),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 2, color: Colors.grey),
      ),
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   // borderSide: const BorderSide(width: 2, color: ThemeColor.error),
      // ),
    ),
  );

  // return TextField(
  //   autofocus: autoFocus,
  //   onChanged: onChanged,
  //   onSubmitted: onSubmitted,
  //   keyboardType: keyboardType,
  //   textInputAction: textInputAction,
  //   obscureText: obscureText,
  //   style: MaterialStateTextStyle.resolveWith(
  //     (Set<MaterialState> states) {
  //       if (states.contains(MaterialState.disabled)) {
  //         return TextStyle(color: colorDisabled);
  //       }
  //       return const TextStyle(color: ThemeColor.blue300);
  //     },
  //   ),
  //   decoration: InputDecoration(
  //     labelText: labelText,
  //     errorText: errorText,
  //     floatingLabelStyle: MaterialStateTextStyle.resolveWith(
  //       (Set<MaterialState> states) {
  //         if (states.contains(MaterialState.disabled)) {
  //           return TextStyle(color: colorDisabled);
  //         }
  //         if (states.contains(MaterialState.error)) {
  //           return const TextStyle(color: ThemeColor.error);
  //         }
  //         return TextStyle(color: color);
  //       },
  //     ),
  //     labelStyle: MaterialStateTextStyle.resolveWith(
  //       (Set<MaterialState> states) {
  //         if (states.contains(MaterialState.disabled)) {
  //           return TextStyle(color: colorDisabled);
  //         }
  //         if (states.contains(MaterialState.error)) {
  //           return const TextStyle(color: ThemeColor.error);
  //         }
  //         return TextStyle(color: color.withOpacity(0.6));
  //       },
  //     ),
  //     floatingLabelBehavior: FloatingLabelBehavior.always,
  //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: BorderSide(width: 2, color: color.withOpacity(0.4)),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: BorderSide(width: 2, color: color),
  //     ),
  //     disabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: const BorderSide(width: 2, color: Colors.grey),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: const BorderSide(width: 2, color: ThemeColor.error),
  //     ),
  //   ),
  // );
}
