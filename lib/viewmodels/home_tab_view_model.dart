import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTabViewModel extends Model {
  int _currentGripNum = 75;
  int _goalGripNum = 100;

  String get today {
    final today = DateTime.now();
    var formatter = new DateFormat('yyyy.MM.dd');
    return formatter.format(today);
  }

  int get currentGripNum => _currentGripNum;

  int get goalGripNum => _goalGripNum;

  double get achievementRate => _currentGripNum / _goalGripNum;
}
