import 'package:flutter/material.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';

class HomeTab extends StatelessWidget {
  final HomeTabViewModel viewModel;

  HomeTab(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text('HOME'));
  }
}
