import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grammer_drill/utils/text_utils.dart';

class Input extends StatelessWidget {
  Input({Key key, isChecking, onChange, correctAnswer, index, text})
      : this._isChecking = isChecking,
        this._onChange = onChange,
        this._index = index,
        this._correctAnswer = correctAnswer,
        this._controller = new TextEditingController.fromValue(
            TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length))),
        super(key: key);

  final TextEditingController _controller;
  final bool _isChecking;
  final Function _onChange;
  final int _index;
  final String _correctAnswer;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white60;
    if (_isChecking && _correctAnswer == _controller.text) {
      color = Colors.green;
    } else if (_isChecking && _correctAnswer != _controller.text) {
      color = Colors.red;
    }
    return Container(
      width: 30,
      child: TextField(
        onChanged: (text) => _onChange(_index, text),
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
        ],
        controller: _controller,
        style: Theme.of(context).textTheme.title.copyWith(color: color, fontFamily: TextUtils.getFontFamily()),
        decoration: InputDecoration(
            focusedBorder: new UnderlineInputBorder(borderSide: new BorderSide(color: color)),
            enabledBorder: new UnderlineInputBorder(borderSide: new BorderSide(color: color)),
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 2)),
      ),
    );
  }
}
