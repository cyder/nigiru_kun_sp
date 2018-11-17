import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final Color buttonColor;
  final VoidCallback callback;

  ErrorDialog({
    this.title,
    this.content,
    this.buttonColor,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(this.title),
      content: new Text(this.content),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text(
            '閉じる',
            style: TextStyle(color: this.buttonColor),
          ),
          onPressed: () {
            callback();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
