import 'package:flutter/material.dart';
import 'package:nigiru_kun/ui/pages/main.dart';
import 'package:nigiru_kun/ui/pages/bluetooth.dart';
import 'package:nigiru_kun/utils/color.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'にぎるくん',
      theme: new ThemeData(
        brightness: Brightness.dark,
        accentColor: CustomColors.primaryColor,
      ),
      home: new MainPage(),
      routes: <String, WidgetBuilder> {
        '/bluetooth': (BuildContext context) => BluetoothPage(),
      },
    );
  }
}
