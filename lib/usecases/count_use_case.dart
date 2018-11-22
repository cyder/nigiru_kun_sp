import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/repositorys/sensor_repository.dart';
import 'package:nigiru_kun/repositorys/setting_repository.dart';
import 'package:nigiru_kun/entities/count_data.dart';

class CountUseCase {
  final SensorRepository _sensorRepository = SensorRepositoryImpl();
  final SettingRepository _settingRepository = SettingRepositoryImpl();

  Observable<int> get observeTodayCount {
    final DateTime now = DateTime.now();
    return _sensorRepository
        .observeCount(DateTime(now.year, now.month, now.day), null)
        .map((list) => list.map((data) => data.count).reduce((a, b) => a + b));
  }

  Observable<List<CountData>> observeDayCount(DateTime from, DateTime to) {
    for (DateTime date = from;
        date.compareTo(to ?? DateTime.now()) < 0;
        date = date.add(Duration(days: 1))) {
    }
    return _sensorRepository.observeCount(from, to).map((data) {
      List<CountData> result = [];
      for (DateTime date = from;
          date.compareTo(to ?? DateTime.now()) < 0;
          date = date.add(Duration(days: 1))) {
        final countList = data
            .where((item) =>
                item.time.year == date.year &&
                item.time.month == date.month &&
                item.time.day == date.day)
            .map((item) => item.count);
        final sum =
            countList.isNotEmpty ? countList.reduce((a, b) => a + b) : 0;
        result.add(CountData(date, sum));
      }
      return result;
    });
  }

  //TODO: 接続時にもストリームを流すようにする
  Observable<double> get observetThreshWeight =>
      _sensorRepository.observeLastInserted
          .map((_) => _sensorRepository.getThreshWeight)
          .distinct((a, b) => a == b);

  void setThreshWeight(double value) {
    print('data:' + (value * 10).toInt().toString());
    _sensorRepository.setThreshWeight(value);
  }

  Observable<int> get observetGoal => _settingRepository.getGoal().take(1);

  void setGoal(int goal) {
    _settingRepository.setGoal(goal);
  }
}
