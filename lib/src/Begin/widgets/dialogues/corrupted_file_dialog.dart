import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/global_variables.dart';

corruptedFile(BuildContext context) async {
  Flushbar(
    messageText: Text("Can't play a corrupted file!",
        style: TextStyle(fontFamily: "Futura", color: Colors.white)),
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
    backgroundColor: glassOpacity,
    flushbarStyle: FlushbarStyle.FLOATING,
    isDismissible: true,
    barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
    margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
    borderRadius: BorderRadius.circular(15),
  )..show(context);
}
