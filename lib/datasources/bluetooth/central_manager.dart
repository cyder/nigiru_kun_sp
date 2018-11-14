import 'dart:async';
import 'dart:core';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_blue/flutter_blue.dart';

class CentralManager {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  StreamSubscription _scanSubscription;
  PublishSubject<ScanResult> _subject = PublishSubject<ScanResult>();
  static const String _NIGIRU_KUN_SERVICE =
      "1db31f9a-9137-44da-9458-a4e642211773";

  Observable<ScanResult> get scannedDevice =>
      _subject.stream.where((scanResult) =>
          scanResult.advertisementData.serviceUuids.first ==
          _NIGIRU_KUN_SERVICE);

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

  _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    _subject.close();
  }
}
