import 'package:nigiru_kun/entities/nigirukun_sensor_data.dart';
import 'package:nigiru_kun/datasources/bluetooth/central_manager.dart';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';
import 'dart:async';

import 'package:nigiru_kun/datasources/databases/model/counts.dart';

abstract class SensorRepository {
  Observable<NigirukunCountSensorData> get observeCount;
}

class SensorRepositoryImpl implements SensorRepository {
  /// Singleton
  static final SensorRepositoryImpl _singleton = SensorRepositoryImpl._internal();
  String path;
  CountProvider dbProvider = CountProvider();

  SensorRepositoryImpl._internal() {
    getDatabasesPath().then((value) {
      path = value + 'nigirukun.db';
      dbProvider.open(path);
    });
  }

  factory SensorRepositoryImpl() {
    return _singleton;
  }

  CentralManager manager = CentralManager();

  @override
  Observable<NigirukunCountSensorData> get observeCount {
    return manager.countStream;//.map((data) {
      //print('in repo ========> ${data.count}========================');
      //dbProvider.insert(Count(null, 10, data.time.toString()));
      //print('in repo ========> ${data.count}============inserted============');
      //var len = dbProvider.getCount(null, null).then((item) => item.length);
      //len.then((s) {
      //  print("in repository ======= >${s}");
      //  return s;
      //});
      //return NigirukunCountSensorData(0, data.time);
    //});
  }
}
