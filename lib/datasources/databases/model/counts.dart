import 'package:sqflite/sqflite.dart';
import 'dart:core';

import 'package:nigiru_kun/datasources/databases/constants.dart';
import 'package:nigiru_kun/datasources/databases/database.dart';

class Count {
  int id;
  double weight;
  String time;

  Count({this.id, this.weight, this.time});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      countId: id,
      countWeight: weight,
      countTime: time
    };
    return map;
  }

  Count.fromMap(Map<String, dynamic> map): this(
    id: map[countId],
    weight: map[countWeight],
    time: map[countTime],
  );

}

class CountProvider {
  final NigirukunDatabase _nigirukunDatabase = NigirukunDatabase();
  Future<Database> initDb() async {
    return _nigirukunDatabase.initDb();
  }

  Future<void> insert(Count count) async {
    await (await _nigirukunDatabase.db).insert(tableCount, count.toMap());
  }


  Future<List<Count>> getCount(DateTime from, DateTime to) async {
    String qFrom = from?.toString() ?? "0000-01-01 00:00:00.000000";
    String qTo = to?.toString() ?? DateTime.now().toString();
    List<Map> maps = await (await _nigirukunDatabase.db).query(tableCount,
      columns: [countId, countWeight, countTime],
      where: '$countTime >= ? AND $countTime <= ?',
      whereArgs: [qFrom, qTo]
    );
    List<Count> result = List<Count>();
    maps.forEach((map) {
      result.add(Count.fromMap(map));
    });
    return result;
  }

  Future close() async => _nigirukunDatabase.close();
}
