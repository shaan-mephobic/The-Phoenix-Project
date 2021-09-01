import 'dart:ui';
import 'package:flutter_remixicon/flutter_remixicon.dart';
import '../../../widgets/switcher_button.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../begin.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  void initState() {
    crossfadeStateChange = true;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    rootCrossfadeState = Provider.of<Leprovider>(context);

    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }
    return Consumer<Leprovider>(
      builder: (context, taste, _) {
        globaltaste = taste;
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          body: Container(
            child: Stack(
              children: [
                BackArt(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: orientedCar
                                          ? deviceWidth / 4
                                          : deviceWidth / 2)),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: orientedCar
                                          ? deviceHeight / 5.5
                                          : deviceHeight / 5.5)),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: orientedCar
                                          ? deviceHeight / 3 / 2
                                          : 30,
                                      right: orientedCar
                                          ? deviceHeight / 3 / 2
                                          : 30),
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          "Phoenix does use the internet for lyrics and images, but collects no data. You could turn off the feature if you wish, below.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "RalewaySB",
                                        fontSize: orientedCar
                                            ? deviceHeight / 26
                                            : deviceHeight / 26,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: orientedCar
                                          ? deviceWidth / 4
                                          : deviceWidth / 2)),
                              Container(
                                height: orientedCar
                                    ? deviceHeight / 3
                                    : deviceWidth / 1.6,
                                width: orientedCar
                                    ? deviceHeight / 1.5
                                    : deviceWidth / 1.1,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth / 27),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 13.0,
                                      offset: kShadowOffset,
                                      
                                    ),
                                  ],
                             
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth / 27),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 20, sigmaY: 20),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth / 27),
                                        border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.04)),
                                        color: Colors.white.withOpacity(0.05),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                            child: Text(
                                              "Your data is Anonymous and isn't stored by phoenix, yet you can turn on Isolation to stop the features.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "RalewaySB",
                                                fontSize:
                                                    
                                                    deviceWidth / 19,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 30)),
                                          
                                          SwitcherButton(
                                            offColor: kMaterialBlack,
                                            onColor: kCorrect,
                                            value: musicBox.get("isolation") ==
                                                    null
                                                ? false
                                                : musicBox.get('isolation'),
                                            onChange: (value) {
                                              // print(anonymous);

                                              musicBox.put("isolation", value);

                                              setState(() {});
                                            },
                                          
                                          ),
                                         
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: orientedCar
                                          ? deviceWidth / 6
                                          : deviceWidth / 4)),
                              Text("#PRIVACYMATTERS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "UrbanSB",
                                    fontSize: orientedCar
                                        ? deviceWidth / 25
                                        : deviceWidth / 22,
                                  )),
                              Padding(padding: EdgeInsets.only(top: 13)),
                           
                            ],
                          ),
                         
                          AppBar(
                            iconTheme: IconThemeData(
                              color: kMaterialBlack,
                            ),
                            elevation: deviceWidth / 60,
                            toolbarHeight: orientedCar
                                ? deviceWidth / 4.2
                                : deviceHeight / 5.5,
                            backgroundColor:
                               
                                Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(deviceWidth / 14),
                              ),
                            ),
                            centerTitle: true,
                            title: Text(
                              "PRIVACY",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: "FuturaR",
                                  fontSize: deviceWidth / 10,
                                  color: kMaterialBlack),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: orientedCar
                                    ? deviceWidth / 4.2 -
                                        deviceWidth / 14 +
                                        MediaQuery.of(context).padding.top
                                    : deviceHeight / 5.5 -
                                        deviceWidth / 14 +
                                        MediaQuery.of(context).padding.top),
                            child: Container(
                              height: deviceWidth / 7,
                              width: deviceWidth / 7,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 1.0,
                                    spreadRadius: deviceWidth / 230,
                                  ),
                                ],
                                color: kMaterialBlack,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                MIcon.riLock2Line,
                                color: kPhoenixColor,
                                size: deviceWidth / 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
