import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/constant/value.constant.dart';

//  date = HttpDate.parse(dateStr);

extension StringExtension on String {
  String get alphanumeric =>
      replaceAll(RegExp(ValueConstant.alphanumericPattern), '');

  String get camelCase => isNotEmpty
      ? split(' ').map((e) => e.length > 2 ? e.titleCase : e).join(' ')
      : '';

  String? fontCodeFormat() {
    var formattedFontCode = '';
    if (characters.first == 'U') {
      final v = int.parse(split('+').last, radix: 16);
      formattedFontCode = String.fromCharCode(v);
    }
    return formattedFontCode;
  }

  bool get isEmail =>
      isNotEmpty && RegExp(ValueConstant.emailPattern).hasMatch(this);

  bool get isUrl =>
      RegExp(ValueConstant.urlPattern, caseSensitive: false).hasMatch(this);

  bool get isVideoFormat => toLowerCase().endsWith('.mp4');

  String get titleCase =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String? phoneFormat({
    String? mobilePrefix,
    bool withPlus = true,
  }) {
    final value = startsWith('0') ? replaceFirst('0', '') : this;
    return '${withPlus ? '+' : ''}$mobilePrefix$value';
  }

  String textMask({String? mobilePrefix}) {
    final value = startsWith('0') ? replaceFirst('0', '') : this;
    final numSpace = value.length > 4 ? value.length - 4 : 0;
    mobilePrefix = mobilePrefix != null ? '+$mobilePrefix' : '';
    return '$mobilePrefix${value.replaceRange(0, numSpace, '*' * numSpace)}';
  }

  DateTime? toDate({String? format = 'yyyy-MM-dd'}) {
    final f = DateFormat(format);
    try {
      return f.parse(this);
    } catch (e) {
      return null;
    }
  }

  DateTime? toTime({String? format = 'HH:mm:ss'}) {
    final f = DateFormat(format);
    try {
      return f.parse(this);
    } catch (e) {
      return null;
    }
  }
}
