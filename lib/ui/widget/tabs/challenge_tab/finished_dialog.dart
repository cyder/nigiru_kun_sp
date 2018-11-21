import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/utils/color.dart';

class FinishedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ChallengeTabViewModel>(
        builder: (context, child, model) => AlertDialog(
              title: new Text('${model.currentHandName}： ${model.resultForce} kg'),
              content: new Text('データを登録しますか？'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    'キャンセル',
                    style: TextStyle(color: Colors.white30),
                  ),
                  onPressed: () {
                    model.cancelChallenge();
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text(
                    '登録',
                    style: TextStyle(color: CustomColors.secondaryColor),
                  ),
                  onPressed: () {
                    model.saveChallenge();
                    Navigator.of(context).pop('saved');
                  },
                ),
              ],
            ));
  }
}
