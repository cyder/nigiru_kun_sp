import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/repositorys/sensor_repository.dart';

class ChallengeUseCase {
  final SensorRepository repository = SensorRepositoryImpl();

  Observable<double> get observeForceWeight {
    return repository.observeForceData
        .map((data) => data.force.reduce((a, b) => a + b))
        .map((weight) => weight < 3.0 ? 0.0 : weight)
        .distinct((a, b) => a == b);
  }
}
