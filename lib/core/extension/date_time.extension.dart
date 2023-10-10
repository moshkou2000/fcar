import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  bool checkTimeOut(int timeout) {
    if (this == null) return false;
    final differenceTime = DateTime.now().difference(this!).inMinutes;
    if (differenceTime >= timeout) {
      return true;
    }
    return false;
  }

  String dateFormat({String? format = 'dd MMMM yyyy'}) {
    final format0 = DateFormat(format);
    return this != null ? format0.format(this!) : '';
  }

  String localDate({String? format = 'en_US'}) {
    DateFormat formatter;
    final date = this ?? DateTime.now();
    formatter = DateFormat.yMMMEd(format);
    return formatter.format(date);
  }

  String timeFormat({String? format = 'HH:mm:ss'}) {
    final f = DateFormat(format);
    return this != null ? f.format(this!) : '';
  }

  DateTime? toBuddhistDate() {
    return this != null
        ? DateTime(this!.year + 543, this!.month, this!.day)
        : null;
  }

  DateTime? toWorldDate() {
    return this != null
        ? DateTime(this!.year - 543, this!.month, this!.day)
        : null;
  }
}
