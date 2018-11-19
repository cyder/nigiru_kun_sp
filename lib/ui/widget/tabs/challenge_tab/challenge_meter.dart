import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/utils/color.dart';
import 'package:nigiru_kun/ui/widget/bars/circular_bar.dart';
import 'package:nigiru_kun/ui/widget/forms/radio_buttons.dart';

class ChallengeMeter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ChallengeTabViewModel>(
        builder: (context, child, model) => new Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: CircularBar(
                percent: model.currentForceRatio,
                progressColor: CustomColors.secondaryColor,
                backgroundColor: CustomColors.secondaryTranslucentColor,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                    RadioButtons<Hand>(
                      items: [
                        RadioItem(id: Hand.Left, label: '左手'),
                        RadioItem(id: Hand.Right, label: '右手'),
                      ],
                      onChange: model.handleCurrentHand,
                      value: model.currentHand,
                      labelTextStyle: TextStyle(fontSize: 20.0),
                      activeColor: CustomColors.secondaryColor,
                    ),
                  ],
                ),
              ),
            ));
  }
}
