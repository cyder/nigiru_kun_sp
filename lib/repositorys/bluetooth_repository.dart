import 'package:nigiru_kun/datasources/bluetooth/nigirukun_peripheral.dart';
import 'package:nigiru_kun/datasources/bluetooth/central_manager.dart';

import 'package:rxdart/rxdart.dart';

abstract class BluetoothRepository {
  Observable<NigirukunPeripheral> scan();
  void connect(NigirukunPeripheral peripheral);
  void disconnect();

  NigirukunPeripheral get connectedNigirukunPeripheral;
}

class BluetoothRepositoryImpl extends BluetoothRepository {
  /// Singleton
  static final BluetoothRepositoryImpl _singleton = BluetoothRepositoryImpl._internal();
  BluetoothRepositoryImpl._internal();

  factory BluetoothRepositoryImpl() {
    return _singleton;
  }

  CentralManager manager = CentralManager();


  @override
  void connect(NigirukunPeripheral peripheral) {
    manager.connect(peripheral);
  }

  @override
  void disconnect() {
    manager.disconnect();
  }

  @override
  Observable<NigirukunPeripheral> scan() {
    manager.startDeviceScan();
    return manager.scannedDevice;
  }

  @override
  NigirukunPeripheral get connectedNigirukunPeripheral => manager.peripheral;
}
