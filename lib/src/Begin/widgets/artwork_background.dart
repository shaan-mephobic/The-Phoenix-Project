import 'dart:ui';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import '../begin.dart';
import 'package:flutter/material.dart';

var globaltaste;

class BackArt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    bool darkModeOn = true;
    if (musicBox.get("dynamicArtDB") ?? true) {

      return Container(
        child: AnimatedCrossFade(

          duration: Duration(milliseconds: crossfadeDuration),
          firstChild: Container(
          
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(art),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
            
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: artworkBlurConst, sigmaY: artworkBlurConst),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                      child: Container(
                    height: orientedCar ? deviceWidth : deviceHeight,
                    width: orientedCar ? deviceHeight : deviceWidth,
       
                  )),
                ),
              ),
            ),
          ),
          secondChild: Container(
            
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(art2),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: artworkBlurConst, sigmaY: artworkBlurConst),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: Container(
                      height: orientedCar ? deviceWidth : deviceHeight,
                      width: orientedCar ? deviceHeight : deviceWidth,
                
                    ),
                  ),
                ),
              ),
            ),
          ),
          crossFadeState:
              first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      );
    

    } else {
      return Container(color: darkModeOn ? kMaterialBlack : Colors.white);
    }
  }
}

