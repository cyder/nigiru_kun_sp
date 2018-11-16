import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';
import 'package:nigiru_kun/ui/widget/home_tab/home_counter.dart';
import 'package:nigiru_kun/ui/widget/forms/number_input.dart';
import 'package:nigiru_kun/utils/color.dart';

class HomeTab extends StatelessWidget {
  final HomeTabViewModel viewModel;

  HomeTab(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<HomeTabViewModel>(
      model: viewModel,
      child: new ScopedModelDescendant<HomeTabViewModel>(
          builder: (context, child, model) => new SingleChildScrollView(
                  child: new Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 20.0,
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Center(
                        child: new Text(
                      'Today ${model.today}',
                      style: const TextStyle(fontSize: 28.0),
                    )),
                    new Center(child: HomeCounter()),
                    new Text(
                      'Settings',
                      style: new TextStyle(
                        fontSize: 32.0,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    new NumberInput(
                      labelText: 'Weight',
                      value: model.weight,
                      unit: 'kg',
                      onEditingComplete: model.setWeight,
                    ),
                    new NumberInput(
                      labelText: 'Goal',
                      value: model.goalGripNum,
                      unit: '回',
                      onEditingComplete: model.setGoalGripNum,
                    ),
                  ],
                ),
              ))),
    );
  }
}
