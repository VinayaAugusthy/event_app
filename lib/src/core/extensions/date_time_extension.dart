import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDate() {
    return DateFormat('dd MMM yyy').format(this);
  }
}
