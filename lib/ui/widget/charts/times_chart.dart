import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimesChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> data;

  TimesChart(this.data);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      data,
      domainAxis: charts.DateTimeAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
        labelStyle: charts.TextStyleSpec(
            fontSize: 10, // size in Pts.
            color: charts.MaterialPalette.white),
        lineStyle:
            charts.LineStyleSpec(color: charts.Color(r: 80, g: 80, b: 80)),
      )),
      primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
            fontSize: 10, // size in Pts.
            color: charts.MaterialPalette.white),
        lineStyle:
            charts.LineStyleSpec(color: charts.Color(r: 80, g: 80, b: 80)),
      )),
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.top,
          outsideJustification: charts.OutsideJustification.endDrawArea,
        )
      ],
    );
  }
}
