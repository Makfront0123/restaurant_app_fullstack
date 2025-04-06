import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
