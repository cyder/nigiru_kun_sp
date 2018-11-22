import 'package:intl/intl.dart';

String formattedDate(DateTime date) {
  final formatter = DateFormat('yyyy.MM.dd');
  return formatter.format(date);
}

bool isSamaDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
