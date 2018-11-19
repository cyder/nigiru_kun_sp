import 'package:intl/intl.dart';

String formattedDate(DateTime date) {
  final formatter = DateFormat('yyyy.MM.dd');
  return formatter.format(date);
}
