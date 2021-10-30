import 'dart:ui';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:flutter/material.dart';

late var globaltaste;

class BackArt extends StatelessWidget {
  const BackArt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (musicBox.get("dynamicArtDB") ?? true) {
      return AnimatedCrossFade(
        duration: Duration(milliseconds: crossfadeDuration),
        firstChild: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(art!),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                tileMode: TileMode.mirror,
                sigmaX: artworkBlurConst,
                sigmaY: artworkBlurConst),
            child: Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.22),
              child: Center(
                child: SizedBox(
                  height: orientedCar ? deviceWidth : deviceHeight,
                  width: orientedCar ? deviceHeight : deviceWidth,
                ),
              ),
            ),
          ),
        ),
        secondChild: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(art2!),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                tileMode: TileMode.mirror,
                sigmaX: artworkBlurConst,
                sigmaY: artworkBlurConst),
            child: Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.22),
              child: Center(
                child: SizedBox(
                  height: orientedCar ? deviceWidth : deviceHeight,
                  width: orientedCar ? deviceHeight : deviceWidth,
                ),
              ),
            ),
          ),
        ),
        crossFadeState:
            first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      );
    } else {
      return Container(color: kMaterialBlack);
    }
  }
}
