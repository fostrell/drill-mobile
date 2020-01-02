import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grammer_drill/utils/text_utils.dart';

class Input extends StatefulWidget {
  Input({Key key, gapNumber})
      : this._gapNumber = gapNumber,
        super(key: key);

  final TextEditingController _controller = TextEditingController();
  _InputState state;

  String get text => _controller.text;

  int get gapNumber => _gapNumber;

  void success(bool success) => state.setSuccess(success);

  void error(bool success) => state.setError(success);

  final int _gapNumber;

  @override
  _InputState createState() {
    state = _InputState();
    return state;
  }
}

class _InputState extends State<Input> {
  bool success = false;
  bool error = false;

  void setSuccess(bool status) => setState(() => success = status);

  void setError(bool status) => setState(() => error = status);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white60;
    if (success) {
      color = Colors.green;
    } else if (error) {
      color = Colors.red;
    }
    return Container(
      width: 30,
      child: TextField(
        onChanged: (text) {
          setSuccess(false);
          setError(false);
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
        ],
        controller: widget._controller,
        style: Theme.of(context).textTheme.title.copyWith(color: color, fontFamily: TextUtils.getFontFamily()),
        decoration: InputDecoration(
            focusedBorder: new UnderlineInputBorder(borderSide: new BorderSide(color: color)),
            enabledBorder: new UnderlineInputBorder(borderSide: new BorderSide(color: color)),
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 2)),
      ),
    );
  }

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }
}
