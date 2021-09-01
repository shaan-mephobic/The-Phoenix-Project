import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

corruptedFile(BuildContext context) async {
  Flushbar(
    messageText: Text("Can't play a corrupted file!",
        style: TextStyle(fontFamily: "FuturaR", color: Colors.white)),
    icon: Icon(
      Icons.error_outline,
      size: 28.0,
      color: Color(0xFFCB0447),
    ),

    shouldIconPulse: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: Duration(seconds: 3),
    borderColor: Colors.white.withOpacity(0.04),
    borderWidth: 1,
    backgroundColor: Colors.white.withOpacity(0.05),
    flushbarStyle: FlushbarStyle.FLOATING,
    isDismissible: true,
    barBlur: 20,
    margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
    borderRadius: BorderRadius.circular(15),

  )..show(context);
}
