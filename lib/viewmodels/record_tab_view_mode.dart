import 'package:scoped_model/scoped_model.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/entities/count_data.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';
import 'package:nigiru_kun/usecases/count_use_case.dart';
import 'package:nigiru_kun/usecases/challenge_use_case.dart';
import 'package:nigiru_kun/utils/color.dart';

class RecordTabViewModel extends Model {
  List<Series<CountData, DateTime>> _homeSeriesList = [];

  List<Series<CountData, DateTime>> get homeSeriesList => _homeSeriesList;

  List<Series<ChallengeData, DateTime>> _challengeSeriesList = [];

  List<Series<ChallengeData, DateTime>> get challengeSeriesList =>
      _challengeSeriesList;

  final CountUseCase countUseCase = CountUseCase();
  final ChallengeUseCase challengeUseCase = ChallengeUseCase();

  void init() {
    countUseCase
        .observeDayCount(DateTime.now().add(Duration(days: -14)), null)
        .listen((data) {
      _homeSeriesList = [
        Series<CountData, DateTime>(
          id: 'home',
          colorFn: (_, __) => CustomColors.primaryChartColor,
          domainFn: (CountData data, _) => data.date,
          measureFn: (CountData data, _) => data.count,
          data: data,
        )
      ];
      notifyListeners();
    });

    Observable.combineLatest2(
      challengeUseCase.observeChallengeList(
          Hand.Right, DateTime.now().add(Duration(days: -30)), null),
      challengeUseCase.observeChallengeList(
          Hand.Left, DateTime.now().add(Duration(days: -30)), null),
      (a, b) => <List<ChallengeData>>[a, b],
    ).listen((data) {
      _challengeSeriesList = [];

      if(data[0] != null) {
        _challengeSeriesList.add(Series<ChallengeData, DateTime>(
          id: 'rightHand',
          displayName: '右手',
          colorFn: (_, __) => CustomColors.secondaryChartColor,
          domainFn: (ChallengeData data, _) => data.date,
          measureFn: (ChallengeData data, _) => data.force,
          data: data[0],
        ));
      }

      if(data[1] != null) {
        _challengeSeriesList.add(Series<ChallengeData, DateTime>(
          id: 'leftHand',
          displayName: '左手',
          colorFn: (_, __) => CustomColors.tertiaryChartColor,
          domainFn: (ChallengeData data, _) => data.date,
          measureFn: (ChallengeData data, _) => data.force,
          data: data[1],
        ));
      }

      notifyListeners();
    });
  }
}
