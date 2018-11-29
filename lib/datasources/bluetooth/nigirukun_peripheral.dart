import 'dart:async';
import 'dart:core';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'nigirukun_profile.dart';
import 'nigirukun_processor.dart';
import 'package:nigiru_kun/entities/nigirukun_sensor_data.dart';

class NigirukunPeripheral {
  /// private variables
  BluetoothDevice _rawPeripheral;
  BluetoothCharacteristic _threshCharacteristic;
  StreamSubscription<BluetoothDeviceState> _deviceStateSubscription;
  PublishSubject<BluetoothService> _serviceStream =
      PublishSubject<BluetoothService>();
  PublishSubject<List<double>> _forceStream = PublishSubject<List<double>>();
  PublishSubject<int> _countStream = PublishSubject<int>();

  /// NIGIRUUN unique uuid
  String uuid;

  /// NIGIRUKUN rssi. When the device is advertisement mode, you can refer to this variable
  int rssi;

  /// stream 4-finger force data
  /// rx stream data
  Observable<NigirukunForceSensorData> get forceStream =>
      _forceStream.stream.map((data) => NigirukunForceSensorData.force(data));

  /// stream count data
  /// rx stream data
  Observable<NigirukunCountSensorData> get countStream =>
      _countStream.stream.map((count) => NigirukunCountSensorData.count(count));

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
    if (_countStream.isClosed) {
      _countStream = PublishSubject<int>();
    }
    _deviceStateSubscription = rawPeripheral.onStateChanged().listen((s){
      if(s == BluetoothDeviceState.connected){
        _rawPeripheral.discoverServices().then((s){
          s.forEach((item) => _serviceStream.add(item));
          //find thresh characteristic
          s.forEach((s) {
            s.characteristics.forEach((characteristic) {
              if (characteristic.uuid.toString() ==
                  NigirukunCharacteristicProfile.THRESH_CHARACTERISTIC) {
                _threshCharacteristic = characteristic;
              }
            });
          });
        });
      }
    });
  }

  /// disconnect peripheral
  void disconnect() {
    _deviceStateSubscription = null;
    _countStream.close();
    _forceStream.close();
  }

  /// read Threshold data
  Future<double> readThresh() async {
    double thresh;
    if (_threshCharacteristic == null) {
      return thresh;
    }
    await _readValue(_threshCharacteristic).then((value) {
      thresh = NigirukunDataProcessor().toThresh(value);
      print("thresh ======== > ${thresh.toString()}");
    });
    return thresh;
  }

  /// write Threshold data
  Future<void> writeThresh(double value) async {
    if (_threshCharacteristic == null) {
      return null;
    }
    await _writeValue(
        _threshCharacteristic, NigirukunDataProcessor().fromThresh(value));
  }

  /// start Notify
  Future<void> startNotify() async {
    _serviceStream.map((item) => item.characteristics).listen((s) async {
      await Future.forEach(s, (characteristic) async {
        if (characteristic.uuid.toString() ==
            NigirukunCharacteristicProfile.FORCE_CHARACTERISTIC) {
          await _rawPeripheral.setNotifyValue(characteristic, true);
        }
        if (characteristic.uuid.toString() ==
            NigirukunCharacteristicProfile.COUNT_CHARACTERISTIC) {

          // reset
          await _writeValue(characteristic, [0, 0, 0, 0]);
          await _rawPeripheral.setNotifyValue(characteristic, true);
        }
        if (characteristic.uuid.toString() ==
            NigirukunCharacteristicProfile.COUNT_CHARACTERISTIC.toUpperCase()) {
          // reset
          await _writeValue(characteristic, [0, 0, 0, 0]);
          await _rawPeripheral.setNotifyValue(characteristic, true);
        }
      });
      print("here");
      s.forEach((item) async => await didNotify(item));
    });
  }

  /// switch with characteristic and readValues
  /// - parameter characteristic Bluetooth Characteristic
  Future<void> didNotify(BluetoothCharacteristic characteristic) async {
    switch (characteristic.uuid.toString()) {
      case NigirukunCharacteristicProfile.FORCE_CHARACTERISTIC:
        _rawPeripheral.onValueChanged(characteristic).listen((value){
          if(_forceStream.isClosed){
            _forceStream = PublishSubject<List<double>>();
          }
          print('data:' + NigirukunDataProcessor().toForce(value).toString());
          _forceStream.add(NigirukunDataProcessor().toForce(value));
          print(
              'force -> ${new DateTime.now().toString()} byte -> ${value.length.toString()}');
          value.forEach((item) => print(item));
        });
        break;
      case NigirukunCharacteristicProfile.COUNT_CHARACTERISTIC:
        _rawPeripheral.onValueChanged(characteristic).listen((value) async {
          if(_countStream.isClosed){
            _countStream = PublishSubject<int>();
          }
          // reset
          await _writeValue(characteristic, [0, 0, 0, 0]);
          _countStream.add(NigirukunDataProcessor().toCount(value));
          print(
              'count -> ${new DateTime.now().toString()} byte -> ${value.length.toString()}');
          value.forEach((item) => print(item));
        });

        break;
      default:
        break;
    }
  }

  Future<void> _writeValue(
      BluetoothCharacteristic characteristic, List<int> value) async {
    await _rawPeripheral.writeCharacteristic(characteristic, value, type: CharacteristicWriteType.withResponse);
  }

  Future<List<int>> _readValue(BluetoothCharacteristic characteristic) async {
    return await _rawPeripheral.readCharacteristic(characteristic);
  }
}
