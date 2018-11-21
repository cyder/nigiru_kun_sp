import 'dart:core';
import 'package:nigiru_kun/datasources/databases/model/goals.dart';

import 'package:rxdart/rxdart.dart';


abstract class SettingRepository {
  Observable<int> getGoal();
  void setGoal(int goal);
}

class SettingRepositoryImpl implements SettingRepository {
  /// Singleton
  static final SettingRepositoryImpl _singleton = SettingRepositoryImpl._internal();

  GoalProvider dbProvider = GoalProvider();

  static const int defaultGoal = 100;

  SettingRepositoryImpl._internal() {
    dbProvider.initDb();
  }

  factory SettingRepositoryImpl() {
    return _singleton;
  }

  @override
  Observable<int> getGoal() {
    //最も新しいレコードをとってくる
    Future<Goal> g = dbProvider.getLatestRecord();

    //レコードが存在しないなら，作る
    if (g == null) {
      dbProvider.insert(Goal.fromDatetime(DateTime.now(), defaultGoal));
      return Observable.just(defaultGoal);
    }
    g.then((goal) => dbProvider.update(Goal.fromDatetime(DateTime.now(), goal.goal)));
    return Observable.fromFuture(g).map((g) => g.goal);
  }

  @override
  void setGoal(int goal) {
    dbProvider.update(Goal.fromDatetime(DateTime.now(), goal));
  }

}