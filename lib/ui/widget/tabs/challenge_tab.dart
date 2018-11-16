import 'package:flutter/material.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';

class ChallengeTab extends StatelessWidget {
  final ChallengeTabViewModel viewModel;

  ChallengeTab(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text('CHALLENGE'));
  }
}
