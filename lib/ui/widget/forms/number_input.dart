import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final String labelText;
  final int value;
  final String unit;
  final ValueChanged<String> onEditingComplete;

  NumberInput({
    Key key,
    this.labelText,
    this.value,
    this.onEditingComplete,
    this.unit,
  }) : super(key: key);

  @override
  _NumberInputState createState() => new _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final inputController = new TextEditingController();
  final focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        inputController.text = widget.value.toString();
        inputController.selection = new TextSelection(
          baseOffset: 0,
          extentOffset: inputController.text.length,
        );
      } else {
        widget.onEditingComplete(inputController.text);
        inputController.text = '${widget.value.toString()} ${widget.unit}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (focusNode.hasFocus) {
      inputController.text = widget.value.toString();
      inputController.selection = new TextSelection(
        baseOffset: 0,
        extentOffset: inputController.text.length,
      );
    } else {
      inputController.text = '${widget.value.toString()} ${widget.unit}';
    }

    return new Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: new TextField(
          controller: inputController,
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: new OutlineInputBorder(),
          ),
        ));
  }
}
