import 'package:nigiru_kun/entities/nigirukun_sensor_data.dart';
import 'package:nigiru_kun/datasources/bluetooth/central_manager.dart';

import 'package:rxdart/rxdart.dart';

abstract class SensorRepository {
  Observable<NigirukunCountSensorData> get observeCount;
}

class SensorRepositoryImpl implements SensorRepository {
  CentralManager manager = new CentralManager();

  @override
  Observable<NigirukunCountSensorData> get observeCount {
    // in case of not connected
    if (manager.peripheral == null) {
      return null;
    }

    return manager.peripheral.countStream;
  }

}