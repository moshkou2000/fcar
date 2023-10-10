import 'package:intl/intl.dart';

extension NumberExtension on num {
  // convert 0/1 to false/true
  bool toBool() => this == 1;

  String toCurrency() {
    return NumberFormat.simpleCurrency(name: 'USD', decimalDigits: 2)
        .format(1000);
  }

  String toCurrency_({String separator = ',', String currency = '\$'}) {
    final value = NumberFormat('#$separator##0', 'en_US');
    return '$currency ${value.format(this)}';
  }

  DateTime toBuddhistDate() {
    final now = DateTime.now();
    final baseDate = DateTime(now.year + 543, now.month, now.day);
    final days = this is int ? this as int : 0;
    final duration = Duration(days: days);
    final resultDate = baseDate.add(duration);
    return resultDate;
  }

  DateTime toWorldDate() {
    final baseDate = DateTime.now();
    final days = this is int ? this as int : 0;
    final duration = Duration(days: days);
    final resultDate = baseDate.add(duration);
    return resultDate;
  }
}
