import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';
import 'package:nigiru_kun/ui/widget/tabs/home_tab/home_counter.dart';
import 'package:nigiru_kun/ui/widget/forms/number_input.dart';
import 'package:nigiru_kun/utils/color.dart';

class HomeTab extends StatefulWidget {
  final HomeTabViewModel viewModel;

  HomeTab(this.viewModel);

  @override
  _HomeTabState createState() => new _HomeTabState(viewModel);
}

class _HomeTabState extends State<HomeTab> {
  final HomeTabViewModel viewModel;

  _HomeTabState(this.viewModel);

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

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
