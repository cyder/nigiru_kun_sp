import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class CentralManager {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  StreamSubscription _scanSubscription;
  Map<DeviceIdentifier, ScanResult> scanResults = new Map();
  static const String _NIGIRU_KUN_SERVICE =
      "0000180F-0000-1000-8000-00805F9B34FB";

  startScan() {
    _scanSubscription = _flutterBlue.scan(
        timeout: const Duration(seconds: 30),
        /*withServices: [new Guid(_NIGIRU_KUN_SERVICE)]*/).listen((scanResult) {
      print('localName: ${scanResult.advertisementData.localName}');
      print('manufacturerData: ${scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${scanResult.advertisementData.serviceData}');
      scanResults[scanResult.device.id] = scanResult;
    }, onDone: _stopScan);
  }

  _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
  }
}
