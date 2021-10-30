import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';

androidRSupport(BuildContext context) async {
  Flushbar(
    messageText: const Text(
        "Feature not available for this android version yet.\nComing soon!",
        style: TextStyle(fontFamily: "Futura", color: Colors.white)),
    icon: const Icon(
      Icons.error_outline,
      size: 28.0,
      color: Color(0xFFCB0447),
    ),
    shouldIconPulse: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: const Duration(seconds: 3),
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
