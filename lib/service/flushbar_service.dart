import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarService {
  static Flushbar info(String title, String message, [IconData iconData]) {
    return Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      flushbarPosition: FlushbarPosition.TOP,
      boxShadows: [BoxShadow(color: Colors.black, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      backgroundColor: Colors.black,
      icon: iconData == null ? null : Icon(
        iconData,
        size: 28.0,
        color: Colors.blue[300],
      ),
      // leftBarIndicatorColor: Colors.blue[300],
      borderRadius: 8,
      isDismissible: true,
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeOut,
      title: title,
      message: message,
      duration: Duration(seconds: 3),
    );
  }
}
