import 'package:sqflite/sqflite.dart';
import 'dart:core';

import 'package:nigiru_kun/datasources/databases/constants.dart';

class NigirukunDatabase {
  Database _db;

  /// Singleton
  static final NigirukunDatabase _singleton = NigirukunDatabase._internal();

  factory NigirukunDatabase() {
    return _singleton;
  }

  NigirukunDatabase._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    // debug用
    // await Sqflite.devSetDebugModeOn(true);

    if (_db != null) {
      return _db;
    }
    String path = await getDatabasesPath() + 'nigirukun.db';
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableForce (
  $forceId integer primary key autoincrement,
  $forceValue integer not null,
  $forceTime text not null,
  $forceHand text not null)
''');
      await db.execute('''
create table $tableCount (
  $countId integer primary key autoincrement,
  $countWeight real not null,
  $countTime text not null)
''');
    });
    return _db;
  }

  Future close() async => _db.close();
}
