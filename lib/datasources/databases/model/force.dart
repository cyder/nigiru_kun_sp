import 'package:sqflite/sqflite.dart';
import 'dart:core';

import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/datasources/databases/constants.dart';
import 'package:nigiru_kun/datasources/databases/database.dart';

class Force {
  int id;
  int value;
  String time;
  String hand;

  Force(this.id, this.value, this.hand, this.time);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      forceId: id,
      forceValue: value,
      forceTime: time,
      forceHand: hand,
    };
    return map;
  }

  Force.fromMap(Map<String, dynamic> map)
      : this(
    map[forceId],
    map[forceValue],
    map[forceHand],
    map[forceTime],
  );
}

class ForceProvider {
  final NigirukunDatabase _nigirukunDatabase = NigirukunDatabase();


  Future<Database> initDb() async {
    return _nigirukunDatabase.initDb();
  }

  Future<void> insert(Force force) async {
    await (await _nigirukunDatabase.db).insert(tableForce, force.toMap());
  }

  Future<List<Force>> getForce({
    Hand hand,
    DateTime from,
    DateTime to,
  }) async {
    String qFrom = from?.toString() ?? "0000-01-01 00:00:00.000000";
    String qTo = to?.toString() ?? DateTime.now().toString();
    String qhand = hand?.toString() ?? Hand.Right;
    String qWhere = hand != null
        ? '$forceTime >= ? AND $forceTime <= ? AND $forceHand == ?'
        : '$forceTime >= ? AND $forceTime <= ?';
    List<String> qWhereArgs = hand != null ? [qFrom, qTo, qhand] : [qFrom, qTo];

    List<Map> maps = await (await _nigirukunDatabase.db).query(tableForce,
        columns: [forceId, forceValue, forceHand, forceTime],
        where: qWhere,
        whereArgs: qWhereArgs);

    List<Force> result = maps.map((map) => Force.fromMap(map)).toList();

    return result;
  }

  Future<Force> getMaxForce(Hand hand) async {
    String qhand = hand?.toString() ?? Hand.Right;
    List<Map> maps = await (await _nigirukunDatabase.db).query(tableForce,
      columns: [forceId, forceValue, forceHand, forceTime],
      where: '$forceHand == ?',
      whereArgs: [qhand],
      orderBy: '$forceValue desc',
      limit: 1,
    );

    return maps.length == 1 ? Force.fromMap(maps.first) : null;
  }

  Future close() async => _nigirukunDatabase.close();
}