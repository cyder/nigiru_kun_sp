import 'package:nigiru_kun/entities/nigirukun_sensor_data.dart';
import 'package:nigiru_kun/datasources/bluetooth/central_manager.dart';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';
import 'dart:async';

import 'package:nigiru_kun/datasources/databases/model/counts.dart';

abstract class SensorRepository {
  void getCount(DateTime from, DateTime to);
  Observable<List<NigirukunCountSensorData>> get observeCount;
  Observable<NigirukunCountSensorData> get observeLastInserted;
}

class SensorRepositoryImpl implements SensorRepository {
  /// Singleton
  static final SensorRepositoryImpl _singleton = SensorRepositoryImpl._internal();
  String path;
  CountProvider dbProvider = CountProvider();
  PublishSubject<List<NigirukunCountSensorData>> _insertedStream = PublishSubject<List<NigirukunCountSensorData>>();
  PublishSubject<NigirukunCountSensorData> _latestNigirukun = PublishSubject<NigirukunCountSensorData>();
  SensorRepositoryImpl._internal() {
    getDatabasesPath().then((value) {
      path = value + 'nigirukun.db';
      dbProvider.open(path);
    });

    manager.countStream.listen((s) {
      for (int i = 0; i < s.count; ++i) {
        dbProvider.insert(Count(id: null,weight: 10,time: s.time.toString()));
        _latestNigirukun.add(NigirukunCountSensorData(1, s.time));
      }
    });
  }

  factory SensorRepositoryImpl() {
    return _singleton;
  }

  CentralManager manager = CentralManager();

  @override
  void getCount(DateTime from, DateTime to) {
    Observable.fromFuture(dbProvider.getCount(null, null))
      .listen((item) {
        List<NigirukunCountSensorData> data = item.map((e) {
          return NigirukunCountSensorData(1, DateTime.parse(e.time));
        }).toList();
      _insertedStream.add(data);
    });
  }

  @override
  Observable<List<NigirukunCountSensorData>> get observeCount => _insertedStream.stream;

  @override
  Observable<NigirukunCountSensorData> get observeLastInserted => _latestNigirukun.stream;
}
