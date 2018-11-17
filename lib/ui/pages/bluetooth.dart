import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/bluetooth_view_model.dart';

class BluetoothPage extends StatelessWidget {
  final viewModel = new BluetoothViewModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BluetoothViewModel>(
      model: viewModel,
      child: new ScopedModelDescendant<BluetoothViewModel>(
          builder: (context, child, model) => GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                appBar: new AppBar(
                  title: Text('にぎるくんと接続'),
                ),
                body: Text('test'),
              ))),
    );
  }
}