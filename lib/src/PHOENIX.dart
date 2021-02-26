import 'package:flutter/material.dart';
import 'Shaan.dart';
import 'app.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class PHOENIX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (stormed == 1) {
      stormed = 2;
    }
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 20,
        title: Text("THE PHOENIX PROJECT",
            style: TextStyle(
                fontFamily: 'InterR',
                fontSize: deviceHeight / 48,
                color: Colors.white)),
        centerTitle: true,
        toolbarHeight: deviceHeight / 12,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/Start/phoenixphoenix.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: GestureDetector(onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  // swiping in right direction

                }
                if (details.delta.dx < 0) {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 300),
                        child: Homie()),
                  );
                }
              }),
            ),
            Positioned(
              child: Align(
                alignment: Alignment(0, 0.95),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dx > 0) {
                        // swiping in right direction

                      }
                      if (details.delta.dx < 0) {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 300),
                              child: Homie()),
                        );
                      }
                    },
                    child: Container(
                      height: deviceHeight / 20,
                      width: deviceWidth / 2.5,
                      color: Colors.black54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: deviceWidth / 2.5 / 3,
                            width: deviceWidth / 2.5 / 3,
                            child: IconButton(
                              iconSize: deviceWidth / 14,
                              tooltip: 'PHOENIX',
                              padding: EdgeInsets.only(bottom: 1),
                              color: const Color(0xFFCB0047),
                              focusColor: Colors.redAccent,
                              icon: Icon(Icons.info_outline),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            height: deviceWidth / 2.5 / 3,
                            width: deviceWidth / 2.5 / 3,
                            child: IconButton(
                              iconSize: deviceWidth / 14,
                              tooltip: " HOME ",
                              padding: EdgeInsets.only(bottom: 1),
                              color: Colors.white,
                              focusColor: Colors.redAccent,
                              icon: Icon(Icons.home_outlined),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 200),
                                      child: Homie()),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: deviceWidth / 2.5 / 3,
                            width: deviceWidth / 2.5 / 3,
                            child: IconButton(
                              iconSize: deviceWidth / 14,
                              tooltip: 'PHOENIX SETUP',
                              padding: EdgeInsets.only(bottom: 1),
                              color: Colors.white,
                              focusColor: Colors.redAccent,
                              icon: Icon(Icons.play_arrow_outlined),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 200),
                                    child: Shaan(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   child: Align(
            //     alignment: Alignment(0.8, 0.7),
            //     child: Container(
            //       child: Text(
            //         "SHΛΛИ FΛYDH",
            //         style: TextStyle(
            //           fontSize: deviceHeight / 50,
            //           fontFamily: "InterR",
            //           color: Colors.white,
            //         ),
            //         textAlign: TextAlign.start,
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              child: Align(
                alignment: Alignment(0, -0.80),
                child: Container(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dx > 0) {
                        // swiping in right direction

                      }
                      if (details.delta.dx < 0) {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 300),
                              child: Homie()),
                        );
                      }
                    },
                    // child: Image.asset(
                    //   'lib/Start/prefinal.png',
                    //   height: deviceWidth / 1,
                    //   width: deviceWidth / 1,
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment(0, 0.1),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      // swiping in right direction

                    }
                    if (details.delta.dx < 0) {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                            child: Homie()),
                      );
                    }
                  },
                  child: Container(
                    child: TypewriterAnimatedTextKit(
                        text: ["THE PHOENIX"],
                        speed: Duration(milliseconds: 100),
                        isRepeatingAnimation: false,
                        textStyle: TextStyle(
                            fontSize: deviceHeight / 32,
                            fontFamily: "NightMachine"),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.topStart),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment(0, 0.20),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      // swiping in right direction

                    }
                    if (details.delta.dx < 0) {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                            child: Homie()),
                      );
                    }
                  },
                  child: Container(
                    child: Text(
                      "LIGHTNING - 2.69",
                      style: TextStyle(
                          fontSize: deviceHeight / 52,
                          fontFamily: "Fontz",
                          color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
