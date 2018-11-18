import 'package:flutter/material.dart';

class WideFlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color fontColor;
  final String label;

  WideFlatButton({
    this.onPressed,
    this.fontColor,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                color: fontColor,
              ),
            )),
      ),
    );
  }
}
