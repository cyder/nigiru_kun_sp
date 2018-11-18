import 'package:sqflite/sqflite.dart';
import 'dart:core';

final String tableCount = "counts";
final String countId = "id";
final String countWeight = "weight";
final String countTime = "time";

class Count {
  int id;
  int weight;
  String time;

  Count(this.id, this.weight, this.time);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      countId: id,
      countWeight: weight,
      countTime: time
    };
    return map;
  }

  Count.fromMap(Map<String, dynamic> map) {
    id = map[countId];
    weight = map[countWeight];
    time = map[countTime];
  }
}

class CountProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableCount (
  $countId integer primary key autoincrement,
  $countWeight text not null,
  $countTime text not null)
''');
    });
  }

  Future<void> insert(Count count) async {
    await db.insert(tableCount, count.toMap());
  }

  Future<List<Count>> getCount(DateTime from, DateTime to) async {
    String qFrom = from?.toString() ?? "0000-01-01 00:00:00.000000";
    String qTo = to?.toString() ?? DateTime.now().toString();
    print("run query ================== >");
    List<Map> maps = await db.rawQuery("SELECT * FROM counts");// WHERE ? BETWEEN ? AND ?",
        //[tableCount, countTime, qFrom, qTo]);
    print(maps);
    print("end query ================== >${maps?.length ?? 0}");
    return maps.map((item) => Count.fromMap(item));
  }

  Future close() async => db.close();
}
