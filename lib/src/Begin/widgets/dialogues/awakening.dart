import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';

class Awakening extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool orientedCar = false;
    // var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 0,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  offset: kShadowOffset,
                ),
              ],
              borderRadius: BorderRadius.circular(kRounded),
              // color: Colors.black12,
            ),
            alignment: Alignment.center,
            height: orientedCar ? deviceHeight / 2 : deviceWidth / 1.2,
            width: orientedCar ? deviceHeight / 2 : deviceWidth / 1.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kRounded),
              // make sure we apply clip it properly
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRounded),
                    border: Border.all(color: Colors.white.withOpacity(0.04)),
                    color: Colors.white.withOpacity(0.05),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlareLoading(
                        height: orientedCar
                            ? deviceHeight / 2.3
                            : deviceWidth / 1.5,
                        width: orientedCar
                            ? deviceHeight / 2.3
                            : deviceWidth / 1.5,
                        startAnimation: 'searching',
                        name: 'assets/res/disc.flr',
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        onError: (_, stacktrace) {},
                        onSuccess: (_) {},
                      ),
                      Container(
                        color: Colors.transparent,
                        height:
                            orientedCar ? deviceHeight / 16 : deviceWidth / 8,
                        width:
                            orientedCar ? deviceHeight / 3.5 : deviceWidth / 2,
                        child: Center(
                          child: AnimatedTextKit(
                            repeatForever: false,
                            animatedTexts: [
                              FlickerAnimatedText('AWAKENING',
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "NightMachine",
                                      fontSize: orientedCar
                                          ? deviceHeight / 24
                                          : deviceWidth / 16),
                                  speed: Duration(seconds: 5)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
