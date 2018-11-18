import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:nigiru_kun/viewmodels/bluetooth_view_model.dart';
import 'package:nigiru_kun/utils/color.dart';

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
                  appBar: AppBar(
                    title: Text('にぎるくんと接続'),
                  ),
                  body: _content(model),
                ),
              )),
    );
  }

  Widget _content(BluetoothViewModel model) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 30.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Opacity(
                opacity:
                    model.currentState == BluetoothState.Connected ? 1.0 : 0.3,
                child: Image.asset('assets/images/peripheral.png'),
              ),
            ),
            Expanded(child: Text(model.message)),
            RaisedButton(
              onPressed: model.handleButton,
              color: CustomColors.primaryColor,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      model.buttonLabel,
                      style: TextStyle(fontSize: 16.0),
                    )),
              ),
            ),
          ],
        ),
      );
}
