import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';

quickTip(BuildContext context) {
  Flushbar(
    messageText: Text(
        "Quick-Tip: Hold the music artwork image to find additional features.",
        style: TextStyle(fontFamily: "Futura", color: Colors.white)),
    icon: Icon(Icons.info_outline_rounded, size: 28.0, color: kCorrect),
    shouldIconPulse: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: Duration(seconds: 5),
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
