import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTabViewModel extends Model {
  String get today {
    final today = DateTime.now();
    var formatter = new DateFormat('yyyy.MM.dd');
    return formatter.format(today);
  }
}
