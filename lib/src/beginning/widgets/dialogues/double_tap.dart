import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/heart.dart';

onDoubleTap(BuildContext context) async {
  HapticFeedback.lightImpact();
  if (!isSongLiked(nowMediaItem.id)) {
    rmLikedSong(nowMediaItem.id);
    Flushbar(
      messageText: Text("Removed From Liked Songs",
          style: TextStyle(fontFamily: "Futura", color: Colors.white)),
      icon: Icon(
        Icons.block_rounded,
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
      barBlur:
          musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
      margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
      borderRadius: BorderRadius.circular(15),
    )..show(context);
  } else {
    addToLikedSong(nowMediaItem.id);

    Flushbar(
      messageText: Text("Added To Liked Songs",
          style: TextStyle(fontFamily: "Futura", color: Colors.white)),
      icon: Icon(
        MdiIcons.heart,
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
      barBlur:
          musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
      margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
      borderRadius: BorderRadius.circular(15),
    )..show(context);
  }
}
