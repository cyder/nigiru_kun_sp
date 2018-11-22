import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/repositorys/sensor_repository.dart';
import 'package:nigiru_kun/repositorys/challenge_repository.dart';
import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';
import 'package:nigiru_kun/utils/date.dart';

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

  Observable<List<ChallengeData>> observeChallengeList(
      Hand hand, DateTime from, DateTime to) {
    return dbRepository
        .observeForce(hand: hand, from: from, to: to)
        .map((list) {
      List<ChallengeData> result = [];
      list.forEach((data) {
        if (result.isEmpty || !isSamaDay(result.last.date, data.date)) {
          result.add(data);
        } else if (result.last.force > data.force) {
          result[result.length - 1] = data;
        }
      });
      return result
          .map((data) => ChallengeData(
                data.hand,
                data.force,
                DateTime(data.date.year, data.date.month, data.date.day),
              ))
          .toList();
    });
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
