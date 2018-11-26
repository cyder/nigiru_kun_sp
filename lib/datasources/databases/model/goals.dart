import 'package:nigiru_kun/datasources/databases/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:nigiru_kun/datasources/databases/constants.dart';



class Goal {
  String date;
  int goal;

  Goal({this.date, this.goal});

  Goal.fromDatetime(DateTime time, int goal){
    String now = DateFormat("yyyy/MM/dd").format(time).toString();
    this.date = now;
    this.goal = goal ?? 0;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      goalDate: date,
      goalGoal: goal
    };
    return map;
  }

  Goal.fromMap(Map<String, dynamic> map): this(
    date: map[goalDate],
    goal: map[goalGoal],
  );
}

class GoalProvider {
  final NigirukunDatabase _nigirukunDatabase = NigirukunDatabase();

  Future<Database> initDb() async {
    return _nigirukunDatabase.initDb();
  }

  Future<void> insert(Goal goal) async {
    await (await _nigirukunDatabase.db).insert(tableGoal, goal.toMap());
  }

  Future<void> update(Goal goal) async {
    if((await getGoal(goal.date)) == null) {
      insert(goal);
    }
    else {
      await (await _nigirukunDatabase.db).update(tableGoal, goal.toMap(),
        where: '$goalDate = ?',
        whereArgs: [goal.date]
      );
    }
  }

  Future<Goal> getGoal(String time) async {
    List<Map> maps = await (await _nigirukunDatabase.db).query(tableGoal,
      columns: [goalDate, goalGoal],
      where: '$goalDate = ?',
      whereArgs: [time]
    );
    if(maps.length == 1) {
      return Goal.fromMap(maps.first);
    }
    return null;
  }

  Future<Goal> getLatestRecord() async {
    List<Map> maps = await (await _nigirukunDatabase.db).query(tableGoal,
      columns: [goalDate, goalGoal],
      orderBy: goalDate+" DESC",
      limit: 1
    );
    if(maps.length == 1) {
      return Goal.fromMap(maps.first);
    }
    return null;
  }



}