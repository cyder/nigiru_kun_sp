import 'package:flutter/material.dart';
import 'package:nigiru_kun/viewmodels/record_tab_view_mode.dart';

class RecordTab extends StatelessWidget {
  final RecordTabViewModel viewModel;

  RecordTab(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text('Record'));
  }
}
