import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/repositorys/sensor_repository.dart';

class CountUseCase {
  SensorRepository repository = SensorRepositoryImpl();

  Observable<int> get observeTodayCount {
    final DateTime now = DateTime.now();
    return repository
        .observeCount(DateTime(now.year, now.month, now.day), null)
        .map((list) => list.map((data) => data.count).reduce((a, b) => a + b));
  }

  //TODO: 接続時にもストリームを流すようにする
  Observable<double> get observetThreshWeight => repository.observeLastInserted
      .map((_) => repository.getThreshWeight)
      .distinct((a, b) => a == b);

  void setThreshWeight(double value) {
    print('data:' + (value * 10).toInt().toString());
    repository.setThreshWeight(value);
  }
}
