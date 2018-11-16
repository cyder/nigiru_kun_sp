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
  List<BluetoothCharacteristic> characteristics;
  PublishSubject<BluetoothService> _serviceStream = PublishSubject<BluetoothService>();
  PublishSubject<List<int>> _forceStream = PublishSubject<List<int>>();
  PublishSubject<List<int>> _countStream = PublishSubject<List<int>>();

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
  void connect() {
    _deviceStateSubscription = rawPeripheral.onStateChanged().listen((s){
      if(s == BluetoothDeviceState.connected){
        _rawPeripheral.discoverServices().then((s){
          s.forEach((item) => _serviceStream.add(item));
          characteristics = s.map((item) => item.characteristics).fold([], ([prev, item]) {item.forEach((item) => prev.add(item));return prev;});
        });
      }
    });
  }


  /// disconnect peripheral
  void disconnect() {
    _deviceStateSubscription = null;
  }


  /// start Notify
  void startNotify() {
    _serviceStream
      .map((item) => item.characteristics)
      .listen((s) {
        Future.forEach(s, (characteristic) async {
          if (characteristic.uuid.toString() == NigirukunCharacteristicProfile.FORCE_CHARACTERISTIC ||
            characteristic.uuid.toString() == NigirukunCharacteristicProfile.COUNT_CHARACTERISTIC){
            await _rawPeripheral.setNotifyValue(characteristic, true);
          }
        });
        s.forEach((item) => didNotify(item));
      });
  }


  /// switch with characteristic and readValues
  /// - parameter characteristic Bluetooth Characteristic
  void didNotify(BluetoothCharacteristic characteristic) async {

    switch (characteristic.uuid.toString()) {
      case NigirukunCharacteristicProfile.FORCE_CHARACTERISTIC:
        _rawPeripheral.onValueChanged(characteristic).listen((value){
          _forceStream.add(value);
          print('force -> ${new DateTime.now().toString()} byte -> ${value.length.toString()}');
          value.forEach((item) => print(item));
        });
        break;
      case NigirukunCharacteristicProfile.COUNT_CHARACTERISTIC:
        _rawPeripheral.onValueChanged(characteristic).listen((value){
          _countStream.add(value);
          print('count -> ${new DateTime.now().toString()} byte -> ${value.length.toString()}');
          value.forEach((item) => print(item));
        });
        break;
      default:
        break;
    }
  }

  void writeValue(BluetoothCharacteristic characteristic, List<int> value) {

  }
}
