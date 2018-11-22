import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:nigiru_kun/viewmodels/record_tab_view_mode.dart';
import 'package:nigiru_kun/ui/widget/charts/bar_times_chart.dart';
import 'package:nigiru_kun/ui/widget/charts/times_chart.dart';
import 'package:nigiru_kun/utils/color.dart';

class RecordTab extends StatefulWidget {
  final RecordTabViewModel viewModel;

  RecordTab(this.viewModel);

  @override
  _RecordTabState createState() => new _RecordTabState(viewModel);
}

class _RecordTabState extends State<RecordTab> {
  final RecordTabViewModel viewModel;

  _RecordTabState(this.viewModel);

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<RecordTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<RecordTabViewModel>(
          builder: (context, child, model) => SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HOMEモード',
                      style: TextStyle(
                        fontSize: 32.0,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    Container(
                      height: 200.0,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: BarTimesChart(model.homeSeriesList),
                    ),
                    Text(
                      'Challengeモード',
                      style: TextStyle(
                        fontSize: 32.0,
                        color: CustomColors.secondaryColor,
                      ),
                    ),
                    Container(
                      height: 220.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: TimesChart(model.challengeSeriesList),
                    ),
                  ],
                ),
              ))),
    );
  }
}
