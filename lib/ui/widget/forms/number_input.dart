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
  final _inputController = new TextEditingController();
  final _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocus);
  }

  @override
  void dispose(){
    _focusNode.removeListener(_handleFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_focusNode.hasFocus) {
      _inputController.text = widget.value.toString();
      _inputController.selection = new TextSelection(
        baseOffset: 0,
        extentOffset: _inputController.text.length,
      );
    } else {
      _inputController.text = '${widget.value.toString()} ${widget.unit}';
    }

    return new Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: new TextField(
          controller: _inputController,
          keyboardType: TextInputType.number,
          focusNode: _focusNode,
          inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: new OutlineInputBorder(),
          ),
        ));
  }

  void _handleFocus() {
    if (_focusNode.hasFocus) {
      _inputController.text = widget.value.toString();
      _inputController.selection = new TextSelection(
        baseOffset: 0,
        extentOffset: _inputController.text.length,
      );
    } else {
      widget.onEditingComplete(_inputController.text);
      _inputController.text = '${widget.value.toString()} ${widget.unit}';
    }
  }
}
