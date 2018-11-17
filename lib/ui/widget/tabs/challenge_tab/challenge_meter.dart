import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/utils/color.dart';
import 'package:nigiru_kun/ui/widget/bars/circular_bar.dart';

class ChallengeMeter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ChallengeTabViewModel>(
        builder: (context, child, model) => new Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: CircularBar(
                percent: model.currentForceRatio,
                progressColor: CustomColors.secondaryColor,
                backgroundColor: CustomColors.secondaryTranslucentColor,
                center: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                      model.currentHandName,
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        new Text(
                          model.currentForce.toString(),
                          style: new TextStyle(fontSize: 50.0),
                        ),
                        new Text(
                          ' kg',
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
