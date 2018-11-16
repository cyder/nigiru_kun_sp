import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';
import 'package:nigiru_kun/utils/color.dart';
import 'package:nigiru_kun/ui/widget/bars/circular_bar.dart';

class HomeCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return new ScopedModelDescendant<HomeTabViewModel>(
        builder: (context, child, model) => new Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: CircularBar(
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
                          style: new TextStyle(fontSize: 40.0),
                        ),
                        new Text(
                          ' / ${model.goalGripNum} 回',
                          style: new TextStyle(fontSize: 16.0),
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
                          style: new TextStyle(fontSize: 40.0),
                        ),
                        new Text(
                          ' %',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                progressColor: CustomColors.primaryColor,
                backgroundColor: CustomColors.primaryTranslucentColor,
              ),
            ));
  }
}
