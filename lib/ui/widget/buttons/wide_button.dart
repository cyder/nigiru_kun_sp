import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String label;

  WideButton({
    this.onPressed,
    this.color,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              label,
              style: TextStyle(fontSize: 16.0),
            )),
      ),
    );
  }
}
