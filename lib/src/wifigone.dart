import 'package:Phoenix/src/Shaan.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Wifigone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Stack(children: [
    // Container(
    //   height: DEVICEHEIGHT,
    //   width: DEVICEWIDTH,
    //   // color: const Color(0x40A8CCD7),
    //   color: Colors.transparent,
    // return Center(
    return Container(
      height: DEVICEWIDTH / 1.5,
      width: DEVICEWIDTH / 1.5,
      child: FlareActor('lib/Start/gravityfalls.flr',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: 'no_netwrok'),
    );
    // );
    // )
    // ]);
  }
}
