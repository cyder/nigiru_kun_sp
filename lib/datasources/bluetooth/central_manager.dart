import 'dart:async';
import 'dart:core';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_blue/flutter_blue.dart';

class CentralManager {
  /// private variables
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  StreamSubscription _scanSubscription;
  PublishSubject<ScanResult> _subject = PublishSubject<ScanResult>();

  /// const value
  static const String _NIGIRU_KUN_SERVICE =
      "1db31f9a-9137-44da-9458-a4e642211773";

  /// Rx stream data
  /// stream scanResult can subscribe when discovered NIGIRUKUN device
  Observable<ScanResult> get scannedDevice =>
      _subject.stream
          .where((scanResult) => scanResult.advertisementData.connectable)
          .where((scanResult) => scanResult.advertisementData.serviceUuids
            .where((item) => item == _NIGIRU_KUN_SERVICE).length == 1
          )
          .distinct(([a, b]) => a.device.id.id == b.device.id.id);


  /// scan devices which has unique NIGIRUKUN service uuid
  /// - parameter timeout: [default 10 seconds] duration of scanning
  startDeviceScan([int timeout = 10]) {
    if (_subject.isClosed) {
      _subject = PublishSubject<ScanResult>();
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
      _subject.add(scanResult);
    }, onDone: _stopScan);
  }

  /// stop scanning
  _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    _subject.close();
  }
}
