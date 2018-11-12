import 'package:flutter/material.dart';
import 'package:nigiru_kun/viewmodels/home_view_model.dart';

class HomePage extends StatelessWidget {
  final HomeViewModel viewModel = new HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('HOME'),
        ),
        body: new Center(child: new Text('ユーザー名:${viewModel.userName}')));
  }
}
