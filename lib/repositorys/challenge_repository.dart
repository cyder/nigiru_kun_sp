import 'package:nigiru_kun/datasources/databases/model/force.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';
import 'package:nigiru_kun/entities/hand.dart';
import 'package:rxdart/rxdart.dart';

abstract class ChallengeRepository {
  void saveData(ChallengeData data);

  Observable<List<ChallengeData>> observeForce({
    Hand hand,
    DateTime from,
    DateTime to,
  });

  Observable<ChallengeData> observeBestForce({Hand hand});
}

class ChallengeRepositoryImp implements ChallengeRepository {
  /// Singleton
  static final ChallengeRepositoryImp _singleton =
      ChallengeRepositoryImp._internal();

  ForceProvider dbProvider = ForceProvider();

  ChallengeRepositoryImp._internal() {
    dbProvider.initDb();
  }

  factory ChallengeRepositoryImp() {
    return _singleton;
  }

  @override
  void saveData(ChallengeData data) {
    dbProvider.insert(Force(
      null,
      data.force,
      data.hand.toString(),
      data.date.toString(),
    ));
  }

  @override
  Observable<List<ChallengeData>> observeForce({
    Hand hand,
    DateTime from,
    DateTime to,
  }) {
    return Observable.fromFuture(dbProvider.getForce(
      hand: hand,
      from: from,
      to: to,
    ))
        .map((item) => item
            .map((force) => ChallengeData(
                  force.hand == Hand.Right.toString() ? Hand.Right : Hand.Left,
                  force.value,
                  DateTime.parse(force.time),
                ))
            .toList())
        .take(1);
  }

  @override
  Observable<ChallengeData> observeBestForce({Hand hand}) {
    return Observable.fromFuture(dbProvider.getMaxForce(hand))
        .map((force) => force != null
            ? ChallengeData(
                force.hand == Hand.Right.toString() ? Hand.Right : Hand.Left,
                force.value,
                DateTime.parse(force.time),
              )
            : null)
        .take(1);
  }
}
