import 'dart:async';
import 'dart:core';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_blue/flutter_blue.dart';

class CentralManager {
  /// private variables
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  BluetoothDevice _device;
  List<BluetoothService> _services;
  StreamSubscription _scanSubscription;
  StreamSubscription<BluetoothDeviceState> _deviceConnection;
  StreamSubscription<BluetoothDeviceState> _deviceStateSubscription;
  PublishSubject<ScanResult> _scanSubject = PublishSubject<ScanResult>();
  PublishSubject<BluetoothDeviceState> _deviceStateSubject = PublishSubject<BluetoothDeviceState>();

  /// const value
  static const String _NIGIRU_KUN_SERVICE =
      "1db31f9a-9137-44da-9458-a4e642211773";

  /// connected device. if it's not connected, device will return null
  BluetoothDevice get device => _device;

  /// scan result data
  /// rx stream scanResult can subscribe when discovered NIGIRUKUN device
  Observable<ScanResult> get scannedDevice =>
      _scanSubject.stream
          .where((scanResult) => scanResult.advertisementData.connectable)
          .where((scanResult) => scanResult.advertisementData.serviceUuids
            .where((item) => item == _NIGIRU_KUN_SERVICE).length == 1
          )
          .distinct(([a, b]) => a.device.id.id == b.device.id.id);

  /// connected bluetooth device state
  /// rx stream BluetoothDeviceState can subscribe when changed connection state
  Observable<BluetoothDeviceState> get deviceState => _deviceStateSubject.stream;

  /// scan devices which has unique NIGIRUKUN service uuid
  /// - parameter timeout: [default 10 seconds] duration of scanning
  startDeviceScan([int timeout = 10]) {
    if (_scanSubject.isClosed) {
      _scanSubject = PublishSubject<ScanResult>();
    }
    _scanSubscription = _flutterBlue
        .scan(
      timeout: Duration(seconds: timeout),
    )
        .listen((scanResult) {
      print('localName: ${scanResult.advertisementData.localName}');
      print('connectable: ${scanResult.advertisementData.connectable}');
      print(
          'manufacturerData: ${scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${scanResult.advertisementData.serviceData}');
      _scanSubject.add(scanResult);
    }, onDone: stopScan);
  }

  /// stop scanning
  stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    _scanSubject.close();
  }

  /// connect device
  /// - parameter device: try to connect device instance
  connect(BluetoothDevice device) {
    _device = device;

    // Connect to device
    _deviceConnection = _flutterBlue.connect(device).listen(null, onDone: disconnect);

    // Update the connection state
    device.state.then((s){
      _deviceStateSubject.add(s);
    });

    //
    _deviceStateSubscription = device.onStateChanged().listen((s){
      if (s == BluetoothDeviceState.connected) {
        device.discoverServices().then((s){
          _services = s;
        });
      }
    });
  }

  /// disconnect device
  disconnect() {
    _deviceConnection?.cancel();
    _deviceStateSubscription = null;
    _deviceStateSubject.close();
    _deviceConnection?.cancel();
    _deviceConnection = null;
    _device = null;
  }
}
