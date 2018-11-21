import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:charts_flutter/flutter.dart';
import 'dart:math' as math;

import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';
import 'package:nigiru_kun/utils/color.dart';

class HomeData {
  final DateTime date;
  final int count;

  HomeData(this.date, this.count);
}

class RecordTabViewModel extends Model {
  final formatter = new DateFormat('dd');

  List<Series<HomeData, DateTime>> _homeSeriesList;

  List<Series<HomeData, DateTime>> get homeSeriesList => _homeSeriesList;

  List<Series<ChallengeData, DateTime>> _challengeSeriesList;

  List<Series<ChallengeData, DateTime>> get challengeSeriesList =>
      _challengeSeriesList;

  RecordTabViewModel() {
    final random = math.Random();
    final List<HomeData> homeData = []; // TODO: 仮データ
    final List<ChallengeData> rightHandChallengeData = []; // TODO: 仮データ
    final List<ChallengeData> leftHandChallengeData = []; // TODO: 仮データ

    for (int i = 0; i < 14; i++) {
      homeData.insert(
        0,
        HomeData(DateTime.now().add(Duration(days: -i)), random.nextInt(1000)),
      );
    }

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

    _homeSeriesList = [
      Series<HomeData, DateTime>(
        id: 'home',
        colorFn: (_, __) => CustomColors.primaryChartColor,
        domainFn: (HomeData data, _) => data.date,
        measureFn: (HomeData data, _) => data.count,
        data: homeData,
      )
    ];

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
