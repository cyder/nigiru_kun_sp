import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/ui/widget/forms/radio_buttons.dart';
import 'package:nigiru_kun/ui/widget/tabs/challenge_tab/challenge_meter.dart';
import 'package:nigiru_kun/utils/hand.dart';
import 'package:nigiru_kun/utils/color.dart';

class ChallengeTab extends StatelessWidget {
  final ChallengeTabViewModel viewModel;

  ChallengeTab(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChallengeTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<ChallengeTabViewModel>(
          builder: (context, child, model) => SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioButtons<Hand>(
                      items: [
                        RadioItem(id: Hand.Left, label: '左手'),
                        RadioItem(id: Hand.Right, label: '右手'),
                      ],
                      onChange: model.handleCurrentHand,
                      value: model.currentHand,
                      labelTextStyle: TextStyle(fontSize: 24.0),
                      activeColor: CustomColors.secondaryColor,
                    ),
                    new Center(child: ChallengeMeter()),
                  ],
                ),
              ))),
    );
  }
}
