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

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? labelText;
  final void Function(String)? onChanged;
  final void Function(String?)? onSubmitted;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final bool autoFocus;
  final bool obscureText;
  final Color color;
  final Color colorDisabled;
  final AutovalidateMode autovalidateMode;

  const InputField({
    this.controller,
    this.initialValue,
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.autofillHints,
    this.autoFocus = false,
    this.obscureText = false,
    this.color = Colors.black,
    this.colorDisabled = Colors.grey,
    this.autovalidateMode = AutovalidateMode.disabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      style: WidgetStateTextStyle.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return TextStyle(color: colorDisabled);
          }
          return const TextStyle(color: Colors.blue);
        },
      ),
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return TextStyle(color: colorDisabled);
            }
            // if (states.contains(MaterialState.error)) {
            //   return const TextStyle(color: ThemeColor.error);
            // }
            return TextStyle(color: color);
          },
        ),
        labelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
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
  }
}
