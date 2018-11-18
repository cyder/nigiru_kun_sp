import 'package:nigiru_kun/entities/nigirukun_sensor_data.dart';
import 'package:nigiru_kun/datasources/bluetooth/central_manager.dart';

import 'package:rxdart/rxdart.dart';

abstract class SensorRepository {
  Observable<NigirukunCountSensorData> get observeCount;
}

class SensorRepositoryImpl implements SensorRepository {
  CentralManager manager = CentralManager();

  @override
  Observable<NigirukunCountSensorData> get observeCount {

    manager.startDeviceScan();
    manager.scannedDevice.listen((peripheral) => manager.connect(peripheral));
    return manager.countStream;
  }

}