import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:charts_flutter/flutter.dart';
import 'dart:math' as math;

import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/entities/count_data.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';
import 'package:nigiru_kun/usecases/count_use_case.dart';
import 'package:nigiru_kun/utils/color.dart';

class RecordTabViewModel extends Model {
  List<Series<CountData, DateTime>> _homeSeriesList = [];

  List<Series<CountData, DateTime>> get homeSeriesList => _homeSeriesList;

  List<Series<ChallengeData, DateTime>> _challengeSeriesList;

  List<Series<ChallengeData, DateTime>> get challengeSeriesList =>
      _challengeSeriesList;

  final CountUseCase countUseCase = CountUseCase();

  RecordTabViewModel() {
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
      print(data);
      notifyListeners();
    });
    final random = math.Random();
    final List<ChallengeData> rightHandChallengeData = []; // TODO: 仮データ
    final List<ChallengeData> leftHandChallengeData = []; // TODO: 仮データ


    for (int i = 0; i < 14; i++) {
      rightHandChallengeData.insert(
        0,
        ChallengeData(
          Hand.Right,
          random.nextInt(50),
          DateTime.now().add(Duration(days: -i)),
        ),
      );

      leftHandChallengeData.insert(
        0,
        ChallengeData(
          Hand.Left,
          random.nextInt(50),
          DateTime.now().add(Duration(days: -i)),
        ),
      );
    }

    _challengeSeriesList = [
      Series<ChallengeData, DateTime>(
        id: 'rightHand',
        displayName: '右手',
        colorFn: (_, __) => CustomColors.secondaryChartColor,
        domainFn: (ChallengeData data, _) => data.date,
        measureFn: (ChallengeData data, _) => data.force,
        data: rightHandChallengeData,
      ),
      Series<ChallengeData, DateTime>(
        id: 'leftHand',
        displayName: '左手',
        colorFn: (_, __) => CustomColors.tertiaryChartColor,
        domainFn: (ChallengeData data, _) => data.date,
        measureFn: (ChallengeData data, _) => data.force,
        data: leftHandChallengeData,
      )
    ];
  }
}
