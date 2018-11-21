import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/repositorys/sensor_repository.dart';
import 'package:nigiru_kun/repositorys/challenge_repository.dart';
import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';

class ChallengeUseCase {
  final SensorRepository sensorRepository = SensorRepositoryImpl();
  final ChallengeRepository dbRepository = ChallengeRepositoryImp();

  Observable<double> get observeForceWeight {
    return sensorRepository.observeForceData
        .map((data) => data.force.reduce((a, b) => a + b))
        .map((weight) => weight < 3.0 ? 0.0 : weight)
        .distinct((a, b) => a == b);
  }

  Observable<double> get observeChallengeResult {
    double max = 0;
    return observeForceWeight
        .map((weight) {
          if (weight > max) {
            max = weight;
          }
          return weight;
        })
        .where((weight) => weight < max / 2)
        .map((_) => max)
        .take(1);
  }

  void startChallenge() {
    sensorRepository.disableCount();
  }

  void stopChallenge() {
    sensorRepository.enableCount();
  }

  void saveData(int weight, Hand hand) {
    dbRepository.saveData(ChallengeData(
      hand,
      weight,
      DateTime.now(),
    ));
  }

  Observable<ChallengeData> get rightBestForce {
    return dbRepository.observeBestForce(hand: Hand.Right);
  }

  Observable<ChallengeData> get leftBestForce {
    return dbRepository.observeBestForce(hand: Hand.Left);
  }
}
