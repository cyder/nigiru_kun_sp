import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';

class HomeTab extends StatelessWidget {
  final HomeTabViewModel viewModel;

  HomeTab(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return new ScopedModel<HomeTabViewModel>(
      model: viewModel,
      child: new ScopedModelDescendant<HomeTabViewModel>(
          builder: (context, child, model) => new SingleChildScrollView(
                  child: new Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 20.0,
                ),
                child: new Column(children: [
                  new Center(
                      child: new Text(
                    'Today ${model.today}',
                    style: const TextStyle(fontSize: 28.0),
                  )),
                  new CircularPercentIndicator(
                    radius: size.width * 0.8,
                    lineWidth: 30.0,
                    animation: true,
                    percent: 0.75,
                    center: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            new Text(
                              "75",
                              style: new TextStyle(fontSize: 50.0),
                            ),
                            new Text(
                              " / 100 回",
                              style: new TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            new Text(
                              "75",
                              style: new TextStyle(fontSize: 50.0),
                            ),
                            new Text(
                              " %",
                              style: new TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Color(0xFFC54244),
                    backgroundColor: Color(0x33C54244),
                  ),
                ]),
              ))),
    );
  }
}
