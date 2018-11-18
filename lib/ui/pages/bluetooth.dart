import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:nigiru_kun/viewmodels/bluetooth_view_model.dart';
import 'package:nigiru_kun/ui/widget/dialogs/error_dialog.dart';
import 'package:nigiru_kun/utils/color.dart';

class BluetoothPage extends StatefulWidget {
  final viewModel = new BluetoothViewModel();

  @override
  _BluetoothPageState createState() => new _BluetoothPageState(viewModel);
}

class _BluetoothPageState extends State<BluetoothPage> {
  final BluetoothViewModel viewModel;

  _BluetoothPageState(this.viewModel);

  @override
  void initState() {
    super.initState();
    viewModel.init();
    viewModel.currentDialog.listen((data) {
      if (data == DialogType.Close) {
        Navigator.of(context).pop();
        return;
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            switch (data) {
              case DialogType.Select:
                return ScopedModel<BluetoothViewModel>(
                  model: viewModel,
                  child: ScopedModelDescendant<BluetoothViewModel>(
                    builder: (context, child, model) => _selectDialog(model),
                  ),
                );
              case DialogType.Error:
                return ErrorDialog(
                  title: 'エラー',
                  content: '予期せぬエラーが発生しました。',
                  buttonColor: CustomColors.primaryColor,
                );
              case DialogType.Close:
                return null;
            }
          }).then((value) {
        if (value == null) {
          viewModel.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BluetoothViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<BluetoothViewModel>(
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

  Widget _selectDialog(BluetoothViewModel model) => SimpleDialog(
      title: Text('接続するデバイスを選択してください。'),
      children: model.deviceList
          .map((device) => SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, device.id);
                  model.selectDevice(device);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('${device.name} (${device.id})'),
                ),
              ))
          .toList());
}
