import 'dart:async';
import 'dart:core';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'nigirukun_profile.dart';

class NigirukunPeripheral {
  /// private variables
  BluetoothDevice _rawPeripheral;
  StreamSubscription<BluetoothDeviceState> _deviceStateSubscription;
  PublishSubject<BluetoothService> _serviceStream = PublishSubject<BluetoothService>();

  /// NIGIRUUN unique uuid
  String uuid;

  /// NIGIRUKUN rssi. When the device is advertisement mode, you can refer to this variable
  int rssi;

  //TODO it should be private parameter
  BluetoothDevice get rawPeripheral => _rawPeripheral;

  /// constructor for device
  /// - parameter peripheral: the device that BluetoothDevice
  NigirukunPeripheral(BluetoothDevice peripheral) {
    _rawPeripheral = peripheral;
    uuid = peripheral.id.id;
    rssi = null;
  }

  /// constructor for advertisement mode device
  /// - parameter sacnResult: ScanResult is a type that can get only scanning.
  NigirukunPeripheral.scanResult(ScanResult result) {
    _rawPeripheral = result.device;
    uuid = result.device.id.id;
    rssi = result.rssi;
  }

  /// connect peripheral. publish stream when discover services
  connect() {
    _deviceStateSubscription = rawPeripheral.onStateChanged().listen((s){
      if(s == BluetoothDeviceState.connected){
        _rawPeripheral.discoverServices().then((s){
          s.forEach((item) => _serviceStream.add(item));
        });
      }
    });
  }


  /// disconnect peripheral
  disconnect() {
    _deviceStateSubscription = null;
  }


  /// start Notify
  startNotify() {
    _serviceStream
        .map((service) => service.characteristics)
        .listen((s) =>
          s.forEach((item) => didNotify(item))
        );
  }


  /// switch with characteristic and readValues
  /// - parameter characteristic Bluetooth Characteristic
  didNotify(BluetoothCharacteristic characteristic) async {
    switch (characteristic.uuid.toString()) {
      case NigirukunCharacteristicProfile.FORCE_CHARACTERISTIC:
        await _rawPeripheral.setNotifyValue(characteristic, true);
        _rawPeripheral.onValueChanged(characteristic).listen((value){
          print(new DateTime.now());
          value.forEach((item) => print(item));
        });
        break;
      default:
        break;
    }
  }
}
