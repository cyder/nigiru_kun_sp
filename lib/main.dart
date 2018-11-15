import 'package:flutter/material.dart';
import 'package:nigiru_kun/ui/pages/main.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'にぎるくん',
      theme: new ThemeData(
        brightness: Brightness.dark,
        accentColor: Color(0xFFC54244),
      ),
      home: new MainPage(),
    );
  }
}
