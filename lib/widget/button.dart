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
    return Padding(
      padding: EdgeInsets.only(
          left: this.right ? (this.padding / 2) : this.padding,
          bottom: this.padding,
          right: this.left ? (this.padding / 2) : this.padding),
      child: OutlineButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          onPressed: this.disabled ? null : this.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.text,
                  style: Theme.of(context).textTheme.title.copyWith(color: Colors.blueGrey),
                ),
              ],
            ),
          )),
    );
  }
}
