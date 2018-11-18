import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';

import 'package:nigiru_kun/ui/widget/dialogs/error_dialog.dart';
import 'package:nigiru_kun/ui/widget/buttons/wide_button.dart';
import 'package:nigiru_kun/ui/widget/buttons/wide_flat_button.dart';
import 'package:nigiru_kun/ui/widget/tabs/challenge_tab/challenge_meter.dart';
import 'package:nigiru_kun/ui/widget/tabs/challenge_tab/best_challenge.dart';
import 'package:nigiru_kun/ui/widget/tabs/challenge_tab/finished_dialog.dart';
import 'package:nigiru_kun/utils/color.dart';

class ChallengeTab extends StatefulWidget {
  final ChallengeTabViewModel viewModel;

  ChallengeTab(this.viewModel);

  @override
  _ChallengeTabState createState() => new _ChallengeTabState(viewModel);
}

class _ChallengeTabState extends State<ChallengeTab> {
  final ChallengeTabViewModel viewModel;

  _ChallengeTabState(this.viewModel);

  @override
  void initState() {
    super.initState();
    viewModel.init();
    viewModel.currentDialog.listen((data) {
      if (data == DialogType.Close) {
        Navigator.of(context).pop();
        return;
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            switch (data) {
              case DialogType.Finished:
                return ScopedModel<ChallengeTabViewModel>(
                  model: viewModel,
                  child: FinishedDialog(),
                );
              case DialogType.Error:
                return ErrorDialog(
                  title: 'エラー',
                  content: '予期せぬエラーが発生しました。',
                  buttonColor: CustomColors.secondaryColor,
                  callback: viewModel.cancelChallenge,
                );
              case DialogType.Close:
                return null;
            }
          });
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChallengeTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<ChallengeTabViewModel>(
        builder: (context, child, model) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BestChallenge(),
                  Expanded(child: Center(child: ChallengeMeter())),
                  model.currentState == ChallengeState.StandBy
                      ? WideButton(
                          label: '開始',
                          onPressed: model.startChallenge,
                          color: CustomColors.secondaryColor,
                        )
                      : WideFlatButton(
                          label: 'キャンセル',
                          onPressed: model.cancelChallenge,
                          fontColor: Colors.white54,
                        ),
                ],
              ),
            ),
      ),
    );
  }
}
