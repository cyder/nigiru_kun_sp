import 'package:nigiru_kun/datasources/databases/model/force.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';

abstract class ChallengeRepository {
  void saveData(ChallengeData data);
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

  void saveData(ChallengeData data) {
    dbProvider.insert(Force(
      null,
      data.force,
      data.hand.toString(),
      data.date.toString(),
    ));
  }
}
