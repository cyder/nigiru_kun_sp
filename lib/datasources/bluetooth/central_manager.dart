import 'dart:async';
import 'dart:core';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'nigirukun_peripheral.dart';
import 'nigirukun_profile.dart';

class CentralManager {
  /// private variables
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  NigirukunPeripheral _peripheral;
  StreamSubscription _scanSubscription;
  StreamSubscription<BluetoothDeviceState> _deviceConnection;
  PublishSubject<ScanResult> _scanSubject = PublishSubject<ScanResult>();
  PublishSubject<BluetoothDeviceState> _deviceStateSubject = PublishSubject<BluetoothDeviceState>();


  /// connected device. if it's not connected, device will return null
  NigirukunPeripheral get peripheral => _peripheral;

  /// scan result data
  /// rx stream scanResult can subscribe when discovered NIGIRUKUN device
  Observable<NigirukunPeripheral> get scannedDevice =>
      _scanSubject.stream
          .where((scanResult) => scanResult.advertisementData.connectable)
          .where((scanResult) => scanResult.advertisementData.serviceUuids
            .where((item) => item == NigirukunServicesProfile.NIGIRUKUN_SERVICE).length == 1
          )
          .map((scanResult) => NigirukunPeripheral.scanResult(scanResult))
          .distinct(([a, b]) => a.uuid == b.uuid);

  /// connected bluetooth device state
  /// rx stream BluetoothDeviceState can subscribe when changed connection state
  Observable<BluetoothDeviceState> get deviceState => _deviceStateSubject.stream;

  /// scan devices which has unique NIGIRUKUN service uuid
  /// - parameter timeout: [default 10 seconds] duration of scanning
  void startDeviceScan([int timeout = 10]) {
    if (_scanSubject.isClosed) {
      _scanSubject = PublishSubject<ScanResult>();
    }
    _scanSubscription = _flutterBlue
        .scan(
      timeout: Duration(seconds: timeout),
    )
        .listen((scanResult) {
      _scanSubject.add(scanResult);
    }, onDone: stopScan);
  }

  /// stop scanning
  void stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    _scanSubject.close();
  }

  /// connect device
  /// - parameter device: try to connect device instance
  void connect(NigirukunPeripheral peripheral) {
    _peripheral = peripheral;

    // Connect to device
    _deviceConnection = _flutterBlue.connect(peripheral.rawPeripheral).listen(null, onDone: disconnect);

    // Update the connection state
    peripheral.rawPeripheral.state.then((s){
      _deviceStateSubject.add(s);
    });
    peripheral.connect();
    peripheral.startNotify();
  }

  /// disconnect device
  void disconnect() {
    _deviceConnection?.cancel();
    _deviceStateSubject.close();
    _deviceConnection?.cancel();
    _deviceConnection = null;
    _peripheral.disconnect();
    _peripheral = null;
  }
}
