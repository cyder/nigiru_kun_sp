import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTabViewModel extends Model {
  int _currentGripNum = 75;
  int _goalGripNum = 100;
  int _weight = 20;

  String get today {
    final today = DateTime.now();
    var formatter = new DateFormat('yyyy.MM.dd');
    return formatter.format(today);
  }

  int get currentGripNum => _currentGripNum;

  int get goalGripNum => _goalGripNum;

  int get weight => _weight;

  double get achievementRate => _currentGripNum / _goalGripNum;

  void setWeight(String value) {
    if (value == '') {
      _weight = 0;
    } else {
      _weight = int.parse(value);
    }
    notifyListeners();
  }

  void setGoalGripNum(String value) {
    if (value == '') {
      _goalGripNum = 0;
    } else {
      _goalGripNum = int.parse(value);
    }
    notifyListeners();
  }
}
