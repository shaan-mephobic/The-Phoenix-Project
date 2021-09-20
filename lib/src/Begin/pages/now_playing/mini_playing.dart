import 'dart:ui';
import 'package:phoenix/src/Begin/widgets/custom/marquee.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../begin.dart';
import 'now_playing.dart';

class Moderna extends StatefulWidget {
  @override
  _ModernaState createState() => _ModernaState();
}

class _ModernaState extends State<Moderna> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: radiusFullscreen,
      ),
      child: Stack(
        children: [
          AnimatedCrossFade(
            duration: Duration(milliseconds: crossfadeDuration),
            firstChild: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(art),
                  fit: BoxFit.fitWidth,
                ),
                color: Colors.black,
                borderRadius: radiusFullscreen,
              ),
              child: Center(
                child: Container(
                  height: 60,
                  width: orientedCar ? deviceHeight : deviceWidth,
                  decoration: BoxDecoration(
                    borderRadius: radiusFullscreen,
                  ),
                ),
              ),
            ),
            secondChild: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(art2),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: radiusFullscreen,
                color: Colors.black,
              ),
              child: Center(
                child: Container(
                  height: 60,
                  width: orientedCar ? deviceHeight : deviceWidth,
                  decoration: BoxDecoration(
                    borderRadius: radiusFullscreen,
                  ),
                ),
              ),
            ),
            crossFadeState:
                first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: radiusFullscreen,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: orientedCar ? 8 : 5, sigmaY: orientedCar ? 8 : 5),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) async {
                  gestureDetectorFoo(details);
                },
                onTap: () async {
                  HapticFeedback.lightImpact();
                  pauseResume();
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: deviceWidth / 18, right: deviceWidth / 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MarqueeText(
                          text: nowMediaItem.title,
                          speed: 20,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Urban",
                            fontSize: 19,
                            shadows: [
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 2.0,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          nowMediaItem.artist,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Urban",
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            shadows: [
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 1.0,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Classix extends StatefulWidget {
  @override
  _ClassixState createState() => _ClassixState();
}

class _ClassixState extends State<Classix> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: crossfadeDuration),
      decoration: BoxDecoration(
        color: musicBox.get("dynamicArtDB") ?? true ? nowColor : kMaterialBlack,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: deviceWidth / 20)),
              Center(
                child: AnimatedCrossFade(
                  duration: Duration(milliseconds: crossfadeDuration),
                  firstChild: Card(
                    elevation: 3,
                    color: Colors.transparent,
                    child: Container(
                      height: musicBox.get("squareArt") ?? true ? 48 : 44,
                      width: musicBox.get("squareArt") ?? true ? 48 : 64,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(art),
                        ),
                      ),
                    ),
                  ),
                  secondChild: Card(
                    elevation: 3,
                    color: Colors.transparent,
                    child: Container(
                      height: musicBox.get("squareArt") ?? true ? 48 : 44,
                      width: musicBox.get("squareArt") ?? true ? 48 : 64,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(art2),
                        ),
                      ),
                    ),
                  ),
                  crossFadeState: first
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) async {
                  gestureDetectorFoo(details);
                },
                onTap: () async {
                  HapticFeedback.lightImpact();
                  pauseResume();
                },
                child: Center(
                  child: Container(
                    width: orientedCar ? deviceHeight / 1.6 : deviceWidth / 1.6,
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MarqueeText(
                          text: nowMediaItem.title,
                          speed: 20,
                          style: TextStyle(
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? nowContrast
                                : Colors.white,
                            fontFamily: "Urban",
                            fontSize: 19,
                            shadows: [
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 2.0,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          nowMediaItem.artist,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? nowContrast
                                : Colors.white70,
                            fontFamily: "Urban",
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            shadows: [
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 1.0,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

gestureDetectorFoo(details) async {
  if (details.primaryVelocity > 0) {
    HapticFeedback.lightImpact();
    audioHandler.skipToPrevious();
  } else if (details.primaryVelocity < 0) {
    HapticFeedback.lightImpact();
    audioHandler.skipToNext();
  }
}
