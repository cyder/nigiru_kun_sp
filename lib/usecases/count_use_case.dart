import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/repositorys/sensor_repository.dart';
import 'package:nigiru_kun/repositorys/setting_repository.dart';

class CountUseCase {
  final SensorRepository _sensorRepository = SensorRepositoryImpl();
  final SettingRepository _settingRepository = SettingRepositoryImpl();

  Observable<int> get observeTodayCount {
    final DateTime now = DateTime.now();
    return _sensorRepository
        .observeCount(DateTime(now.year, now.month, now.day), null)
        .map((list) => list.map((data) => data.count).reduce((a, b) => a + b));
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
