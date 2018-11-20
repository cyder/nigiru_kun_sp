import 'package:nigiru_kun/entities/nigirukun_sensor_data.dart';
import 'package:nigiru_kun/datasources/bluetooth/central_manager.dart';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';

import 'package:nigiru_kun/datasources/databases/model/counts.dart';
import 'package:nigiru_kun/datasources/databases/model/force.dart';

abstract class SensorRepository {
  void getCount(DateTime from, DateTime to);

  Observable<List<NigirukunCountSensorData>> get observeCount;

  Observable<NigirukunCountSensorData> get observeLastInserted;

  Observable<List<NigirukunForceSensorData>> observeForce({
    Hand hand,
    DateTime from,
    DateTime to,
  });

  Observable<NigirukunForceSensorData> observeBestForce({Hand hand});
}

class SensorRepositoryImpl implements SensorRepository {
  /// Singleton
  static final SensorRepositoryImpl _singleton =
      SensorRepositoryImpl._internal();
  String path;
  CountProvider countProvider = CountProvider();
  ForceProvider forceProvider = ForceProvider();
  PublishSubject<List<NigirukunCountSensorData>> _insertedStream =
      PublishSubject<List<NigirukunCountSensorData>>();
  PublishSubject<NigirukunCountSensorData> _latestNigirukun =
      PublishSubject<NigirukunCountSensorData>();

  SensorRepositoryImpl._internal() {
    getDatabasesPath().then((value) {
      path = value + 'nigirukun.db';
      countProvider.open(path);
      forceProvider.open(path);
    });

    manager.countStream.listen((s) {
      for (int i = 0; i < s.count; ++i) {
        countProvider
            .insert(Count(id: null, weight: 10, time: s.time.toString()));
        _latestNigirukun.add(NigirukunCountSensorData(1, s.time));
      }
    });

    // TODO: BLEで送られてきたデータをforce tableに挿入する
  }

  factory SensorRepositoryImpl() {
    return _singleton;
  }

  CentralManager manager = CentralManager();

  @override
  void getCount(DateTime from, DateTime to) {
    Observable.fromFuture(countProvider.getCount(null, null)).listen((item) {
      List<NigirukunCountSensorData> data = item.map((e) {
        return NigirukunCountSensorData(1, DateTime.parse(e.time));
      }).toList();
      _insertedStream.add(data);
    });
  }

  @override
  Observable<List<NigirukunCountSensorData>> get observeCount =>
      _insertedStream.stream;

  @override
  Observable<NigirukunCountSensorData> get observeLastInserted =>
      _latestNigirukun.stream;

  @override
  Observable<List<NigirukunForceSensorData>> observeForce({
    Hand hand,
    DateTime from,
    DateTime to,
  }) {
    return Observable.fromFuture(forceProvider.getForce(
      hand: hand,
      from: from,
      to: to,
    )).map((item) => item.map((force) => NigirukunForceSensorData(
          force.value,
          DateTime.parse(force.time),
          force.hand == Hand.Right.toString() ? Hand.Right : Hand.Left,
        )));
  }

  @override
  Observable<NigirukunForceSensorData> observeBestForce({Hand hand}) {
    return Observable.fromFuture(forceProvider.getMaxForce(hand))
        .map((force) => NigirukunForceSensorData(
              force.value,
              DateTime.parse(force.time),
              force.hand == Hand.Right.toString() ? Hand.Right : Hand.Left,
            ));
  }
}
