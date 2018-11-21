import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';
import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/utils/color.dart';
import 'package:nigiru_kun/utils/date.dart';

class BestChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ChallengeTabViewModel>(
        builder: (context, child, model) => Container(
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white30),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                      child: Text(
                    '自己ベスト',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: CustomColors.secondaryColor,
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Expanded(child: _challengeData(model.leftBest)),
                        Expanded(child: _challengeData(model.rightBest)),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _challengeData(ChallengeData data) => Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              data?.hand == Hand.Right ? '右手' : '左手',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          new Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              new Text(
                data?.force?.toInt()?.toString() ?? '--',
                style: new TextStyle(fontSize: 28.0),
              ),
              new Text(
                ' kg /${data != null ? formattedDate(data.date) : '--'}',
                style: new TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ],
      ));
}
