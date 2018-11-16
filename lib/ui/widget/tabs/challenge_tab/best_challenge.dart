import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';

class BestChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<ChallengeTabViewModel>(
        builder: (context, child, model) => new Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            '左手',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            new Text(
                              model.leftBestWeight.toString(),
                              style: new TextStyle(fontSize: 32.0),
                            ),
                            new Text(
                              ' kg /${model.leftBestDate}',
                              style: new TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                '右手',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                new Text(
                                  model.rightBestWeight.toString(),
                                  style: new TextStyle(fontSize: 32.0),
                                ),
                                new Text(
                                  ' kg /${model.rightBestDate}',
                                  style: new TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ));
  }
}
