import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';

quickTip(BuildContext context) {
  Flushbar(
    messageText: const Text(
        "Quick-Tip: Tap the music artwork image to find additional options.",
        style: TextStyle(fontFamily: "Futura", color: Colors.white)),
    icon: Icon(Icons.info_outline_rounded, size: 28.0, color: kCorrect),
    shouldIconPulse: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: const Duration(seconds: 5),
    borderColor: Colors.white.withOpacity(0.04),
    borderWidth: 1,
    backgroundColor: glassOpacity!,
    flushbarStyle: FlushbarStyle.FLOATING,
    isDismissible: true,
    barBlur: musicBox.get("glassBlur") ?? 18,
    margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
    borderRadius: BorderRadius.circular(15),
  ).show(context);
}
