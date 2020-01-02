import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool right;
  final bool left;
  final bool disabled;
  final String text;
  final double padding;
  final VoidCallback onPressed;

  const Button(
      {Key key,
      this.text,
      this.disabled = false,
      this.right = false,
      this.left = false,
      this.padding = 16.0,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = disabled
        ? Theme.of(context).textTheme.title.copyWith(color: Colors.white12)
        : Theme.of(context).textTheme.title;
    Color borderColor = disabled ? Colors.white10 : Colors.white24;
    return Padding(
      padding: EdgeInsets.only(
          left: this.right ? (this.padding / 2) : this.padding,
          bottom: this.padding,
          right: this.left ? (this.padding / 2) : this.padding),
      child: OutlineButton(
          disabledBorderColor: borderColor,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          onPressed: this.disabled ? null : this.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.text,
                  style: textStyle,
                ),
              ],
            ),
          )),
    );
  }
}
