import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

final String tableGoal = "goals";
final String goalDate = "date";
final String goalGoal = "goal";

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
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    if(_db != null) {
      return _db;
    }
    String path = await getDatabasesPath() + 'nigirukun.db';
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableGoal (
  $goalDate text primary key,
  $goalGoal integer not null)
''');
        });
    return _db;
  }

  Future<void> insert(Goal goal) async {
    await (await db).insert(tableGoal, goal.toMap());
  }

  Future<void> update(Goal goal) async {
    if(getGoal(goal.date) == null) {
      insert(goal);
    }
    else {
      await (await db).update(tableGoal, goal.toMap(),
        where: '$goalDate = ?',
        whereArgs: [goal.date]
      );
    }
  }

  Future<Goal> getGoal(String time) async {
    List<Map> maps = await (await db).query(tableGoal,
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
    List<Map> maps = await (await db).query(tableGoal,
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