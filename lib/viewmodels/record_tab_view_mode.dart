import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:charts_flutter/flutter.dart';
import 'dart:math' as math;

class HomeData {
  final DateTime date;
  final int count;

  HomeData(this.date, this.count);
}

class ChallengeData {
  final DateTime date;
  final double force;

  ChallengeData(this.date, this.force);
}

class RecordTabViewModel extends Model {
  final formatter = new DateFormat('dd');

  List<Series<HomeData, DateTime>> _homeSeriesList;

  List<Series<HomeData, DateTime>> get homeSeriesList => _homeSeriesList;


class RecordTabViewModel extends Model {}

  RecordTabViewModel() {
    final random = math.Random();
    final List<HomeData> homeData = []; // TODO: 仮データ

    for (int i = 0; i < 14; i++) {
      homeData.insert(
        0,
        HomeData(DateTime.now().add(Duration(days: -i)), random.nextInt(1000)),
      );
    }

    _homeSeriesList = [
      Series<HomeData, DateTime>(
        id: 'home',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (HomeData data, _) => data.date,
        measureFn: (HomeData data, _) => data.count,
        data: homeData,
      )
    ];
  }
}
