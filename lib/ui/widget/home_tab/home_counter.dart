import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';

class HomeCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return new ScopedModelDescendant<HomeTabViewModel>(
        builder: (context, child, model) => new Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: new CircularPercentIndicator(
                radius: size.width * 0.8,
                lineWidth: 30.0,
                animation: true,
                percent:
                    model.achievementRate < 1.0 ? model.achievementRate : 1.0,
                center: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        new Text(
                          '${model.currentGripNum}',
                          style: new TextStyle(fontSize: 50.0),
                        ),
                        new Text(
                          ' / ${model.goalGripNum} 回',
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        new Text(
                          '${(model.achievementRate * 100).toStringAsFixed(1)}',
                          style: new TextStyle(fontSize: 50.0),
                        ),
                        new Text(
                          ' %',
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Color(0xFFC54244),
                backgroundColor: Color(0x33C54244),
              ),
            ));
  }
}
