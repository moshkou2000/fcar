import 'package:flutter/services.dart';

import '../../config/constant/value.constant.dart';

/// TextInputFormatter
/// Whitelisting & Blacklisting
/// learn more: https://blog.0xba1.xyz/0522/dart-flutter-regexp/

// formatter
final formatter2Decimal =
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'));
final formatterEmail =
    FilteringTextInputFormatter.allow(RegExp(ValueConstant.emailPattern));
final formatterEmoji =
    FilteringTextInputFormatter.deny(RegExp(ValueConstant.emojiPattern));
final formatterSpecialCharacter = FilteringTextInputFormatter.deny(
    RegExp(ValueConstant.specialCharacterPattern));
final formatterSpace =
    FilteringTextInputFormatter.deny(RegExp(ValueConstant.spacePattern));
final formatterAlphanumeric = FilteringTextInputFormatter.allow(
    RegExp(ValueConstant.alphanumericPattern));
final formatterAlphanumericWithSpace = FilteringTextInputFormatter.allow(
    RegExp(ValueConstant.alphanumericWithSpacePattern));

class TextareaFormatter extends TextInputFormatter {
  final int maxLines;

  TextareaFormatter({required this.maxLines});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLines < 2) {
      return newValue;
    } else if (newValue.text == '') {
      return newValue;
    } else {
      final b = '\n'.allMatches(newValue.text).length + 1;
      return b > maxLines ? oldValue : newValue;
    }
  }
}

class CapitalizationTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MobileNumberFormatter extends TextInputFormatter {
  // temp is an example
  final int temp;

  MobileNumberFormatter({required this.temp});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else {
      final text = newValue.text;
      final length = text.length;
      switch (temp) {
        case 1:
          if (length == 1) {
            if (!text.startsWith(RegExp(r'[689]'))) return oldValue;
          } else if (length > 12) {
            return oldValue;
          }
          return newValue;
        case 2:
          if (length == 1) {
            if (!text.startsWith('8')) return oldValue;
          } else if (length > 12) {
            return oldValue;
          }
          return newValue;
        default:
          if (length == 1) {
            if (!text.startsWith('0')) return oldValue;
          } else if (length == 2) {
            if (!text.startsWith('01')) return oldValue;
          } else if (length > 11) {
            return oldValue;
          }
          return newValue;
      }
    }
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else {
      final v = double.tryParse(newValue.text);
      if (v != null) {
        if (v < min) {
          return const TextEditingValue()
              .copyWith(text: min.toStringAsFixed(2));
        } else {
          return v > max ? oldValue : newValue;
        }
      }
      return newValue;
    }
  }
}
