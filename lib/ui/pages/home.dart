import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:nigiru_kun/viewmodels/home_view_model.dart';
import 'package:nigiru_kun/datasources/bluetooth/nigirukun_peripheral.dart';

class HomePage extends StatefulWidget {
  @override
  MyState createState() => new MyState();
}

class MyState extends State<HomePage> {
  final HomeViewModel viewModel = new HomeViewModel();
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HOME'),
      ),
      body: ListView(
        children: <Widget>[
          FlatButton(onPressed: _setWeught, child: new Icon(Icons.border_color)),
          FlatButton(onPressed: _getWeught, child: new Icon(Icons.book)),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.bluetooth), onPressed: _update),
    ); // TODO: implement build
  }

  _update() {
    viewModel.manager.startDeviceScan();
    viewModel.manager.scannedDevice.listen((peripheral) {
      viewModel.manager.connect(peripheral);
    });
    viewModel.repository.observeLastInserted?.listen((item) {
      viewModel.repository.getCount(null, null);
    });
    viewModel.repository.observeCount?.listen((s) {
      print('===================count in home => ${s.length}');
    });

    //viewModel.manager.startDeviceScan();
    //viewModel.manager.scannedDevice.listen(_addWidgetsToResult);
  }

  _setWeught() {
   // viewModel.repository.setWeight(80);
  }

  _getWeught() {
    print(">>>>>>>>>>>>>>>>weight<<<<<<<<<<<<");
    //print('????????????????===================weight => ${viewModel.repository.weight.toString()}');
  }

  _addWidgetsToResult(NigirukunPeripheral peripheral) {
    setState(() {
      widgets = new List.from(widgets);
      widgets.add(new Text("NIGIRUKUN " + peripheral.rssi.toString()));
      //viewModel.manager.connect(peripheral);
    });
  }
}
