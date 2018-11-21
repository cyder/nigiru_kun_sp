import 'package:nigiru_kun/entities/nigirukun_sensor_data.dart';
import 'package:nigiru_kun/datasources/bluetooth/central_manager.dart';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';

import 'package:nigiru_kun/datasources/databases/model/counts.dart';

abstract class SensorRepository {
  void setThreshWeight(int value);
  int get getThreshWeight;
  Observable<List<NigirukunCountSensorData>> getCount(
      DateTime from, DateTime to);

  PublishSubject<List<NigirukunCountSensorData>> observeCount(
      DateTime from, DateTime to);

  Observable<NigirukunCountSensorData> get observeLastInserted;
  Observable<NigirukunForceSensorData> get observeForceData;
}

class SensorRepositoryImpl implements SensorRepository {
  /// Singleton
  static final SensorRepositoryImpl _singleton =
      SensorRepositoryImpl._internal();
  String path;
  CountProvider dbProvider = CountProvider();

  int _latestWeight;
  PublishSubject<List<NigirukunCountSensorData>> _insertedStream = PublishSubject<List<NigirukunCountSensorData>>();
  PublishSubject<NigirukunCountSensorData> _latestNigirukun = PublishSubject<NigirukunCountSensorData>();
  SensorRepositoryImpl._internal() {
    dbProvider.initDb();

    manager.countStream.listen((s) {
      Observable.fromFuture(manager.peripheral.readThresh())
        .listen((weight) {
          _latestWeight = weight;
          for (int i = 0; i < s.count; ++i) {
            dbProvider.insert(Count(id: null,weight: weight,time: s.time.toString()));
            _latestNigirukun.add(NigirukunCountSensorData(1, s.time));
          }
      });
    });
  }

  factory SensorRepositoryImpl() {
    return _singleton;
  }

  CentralManager manager = CentralManager();

  @override
  Observable<List<NigirukunCountSensorData>> getCount(
      DateTime from, DateTime to) {
    return Observable.fromFuture(dbProvider.getCount(from, to))
        .map((item) => item.map((e) {
              return NigirukunCountSensorData(1, DateTime.parse(e.time));
            }).toList());
  }

  @override
  PublishSubject<List<NigirukunCountSensorData>> observeCount(
      DateTime from, DateTime to) {
    final PublishSubject<List<NigirukunCountSensorData>> _insertedStream =
        PublishSubject<List<NigirukunCountSensorData>>();

    getCount(from, to).listen((data) {
      _insertedStream.add(data);
    });

    _latestNigirukun.listen((_) {
      getCount(from, to).listen((data) {
        _insertedStream.add(data);
      });
    });

    return _insertedStream;
  }

  @override
  Observable<NigirukunCountSensorData> get observeLastInserted => _latestNigirukun.stream;

  @override
  Observable<NigirukunForceSensorData> get observeForceData => manager.forceStream;

  @override
  int get getThreshWeight => _latestWeight;

  @override
  void setThreshWeight(int value) {
    if (manager?.peripheral == null) return;
    manager.peripheral.writeThresh(value);
  }

}
