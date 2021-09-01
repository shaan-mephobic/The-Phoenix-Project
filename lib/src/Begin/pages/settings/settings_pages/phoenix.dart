import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:phoenix/src/Begin/pages/settings/settings_pages/privacy.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:phoenix/src/Begin/pages/settings/settings_pages/license.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../begin.dart';

class Phoenix extends StatefulWidget {
  @override
  _PhoenixState createState() => _PhoenixState();
}

class _PhoenixState extends State<Phoenix> {
  @override
  void initState() {
    rootCrossfadeState = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rootCrossfadeState = Provider.of<Leprovider>(context);
    int randomNumber = random.nextInt(quotes.length);
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }
    return Consumer<Leprovider>(builder: (context, taste, _) {
      globaltaste = taste;
      return Scaffold(
        backgroundColor: kMaterialBlack,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Stack(
            children: [
              BackArt(),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width:
                          orientedCar ? deviceWidth / 1.8 : deviceWidth / 1.8,
                      height: orientedCar
                          ? deviceWidth / 2.5 +
                              deviceWidth / 5 +
                              deviceWidth / 13
                          : deviceWidth / 1.5 +
                              deviceWidth / 4 +
                              deviceWidth / 12,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(
                                top: orientedCar
                                    ? deviceWidth / 6
                                    : deviceWidth / 5),
                            width: orientedCar
                                ? deviceWidth / 1.8
                                : deviceWidth / 1.8,
                            height: orientedCar
                                ? deviceWidth / 2.8 + deviceWidth / 5
                                : deviceWidth / 1.8 + deviceWidth / 4,
                            child: Center(
                              child: Image.asset(
                                "assets/res/phoenix.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.only(top: 10),
                            child:
                                //  AnimatedTextKit(
                                //   animatedTexts: [
                                Text(
                              "PHOENIX",
                              // cursor: " ",
                              // speed: Duration(milliseconds: 70),
                              style: TextStyle(
                                  color: Colors.white,
                                  inherit: false,
                                  fontSize: orientedCar
                                      ? deviceWidth / 18
                                      : deviceWidth / 13,
                                  fontFamily: "NightMachine"),
                              textAlign: TextAlign.start,
                            ),
                            // ],
                            // isRepeatingAnimation: false,
                          ),
                          // ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          Text(
                            "HERTZ",
                            style: TextStyle(
                              color: Colors.white,
                              inherit: false,
                              fontFamily: "UrbanSB",
                              fontSize: orientedCar
                                  ? deviceWidth / 31
                                  : deviceWidth / 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: orientedCar ? deviceWidth / 8 : deviceWidth / 4),
                    ),
                    Container(
                      height:
                          orientedCar ? deviceHeight / 4 : deviceWidth / 1.6,
                      width: orientedCar ? deviceHeight / 2 : deviceWidth / 1.1,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 13.0,
                            offset: kShadowOffset,
                            // spreadRadius: 7,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(kRounded),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kRounded),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kRounded),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.04)),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 16, left: 16),
                                  child: Text(
                                    "The Phoenix Project will forever be free and open-source.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        inherit: false,
                                        fontSize: orientedCar
                                            ? deviceWidth / 32
                                            : deviceWidth / 28,
                                        fontFamily: "InterR"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: orientedCar
                                          ? deviceWidth / 16
                                          : deviceWidth / 16),
                                ),
                                Text(
                                  '@SHΛΛИ FΛYDH',
                                  style: TextStyle(
                                    fontFamily: 'InterR',
                                    color: Colors.white,
                                    fontSize: orientedCar
                                        ? deviceWidth / 27
                                        : deviceWidth / 25,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: orientedCar
                                          ? deviceWidth / 32
                                          : deviceWidth / 32),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: orientedCar
                                                ? deviceWidth / 17
                                                : deviceWidth / 17)),
                                    IconButton(
                                        iconSize: orientedCar
                                            ? deviceWidth / 17
                                            : deviceWidth / 17,
                                        icon: Icon(MdiIcons.gmail,
                                            color: Colors.white),
                                        onPressed: () {
                                          final Uri emailLaunchUri = Uri(
                                            scheme: 'mailto',
                                            path: 'shaanfaydhphoenix@gmail.com',
                                          );
                                          launch(emailLaunchUri.toString());
                                        }),
                                    IconButton(
                                        iconSize: orientedCar
                                            ? deviceWidth / 17
                                            : deviceWidth / 17,
                                        icon: Icon(MdiIcons.github,
                                            color: Colors.white),
                                        onPressed: () async {
                                          const String _url =
                                              "https://github.com/shaan-mephobic/The-Phoenix-Project";
                                          await canLaunch(_url)
                                              ? await launch(_url)
                                              : throw 'Could not launch $_url';
                                        }),
                                    IconButton(
                                        iconSize: orientedCar
                                            ? deviceWidth / 17
                                            : deviceWidth / 17,
                                        icon: Icon(Ionicons.logo_paypal,
                                            color: Colors.white),
                                        onPressed: () async {
                                          Flushbar(
                                            messageText: Text(
                                                "Money doesn't interest me. Have a great day!",
                                                style: TextStyle(
                                                    fontFamily: "FuturaR",
                                                    color: Colors.white)),
                                            icon: Icon(
                                              Icons.money_off_csred_outlined,
                                              size: 28.0,
                                              color: kCorrect,
                                            ),

                                            shouldIconPulse: true,
                                            dismissDirection:
                                                FlushbarDismissDirection
                                                    .HORIZONTAL,
                                            duration: Duration(seconds: 2),
                                            borderColor:
                                                Colors.white.withOpacity(0.04),
                                            borderWidth: 1,
                                            backgroundColor:
                                                Colors.white.withOpacity(0.05),
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
                                            isDismissible: true,
                                            barBlur: 20,
                                            margin: EdgeInsets.only(
                                                bottom: 20, left: 8, right: 8),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            // leftBarIndicatorColor:
                                            //     Color(0xFFCB0047),
                                          )..show(context);
                                          await Future.delayed(
                                              Duration(seconds: 2));
                                          const String _url =
                                              "https://www.youtube.com/watch?v=dQw4w9WgXcQ";
                                          await canLaunch(_url)
                                              ? await launch(_url)
                                              : throw 'Could not launch $_url';
                                        }),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: orientedCar
                                                ? deviceWidth / 17
                                                : deviceWidth / 17)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top:
                              orientedCar ? deviceWidth / 10 : deviceWidth / 8),
                    ),
                    Container(
                      height: orientedCar ? deviceWidth / 3 : deviceWidth / 3.0,
                      width:
                          orientedCar ? deviceWidth / 1.5 : deviceWidth / 1.5,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 13.0,
                            offset: kShadowOffset,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(kRounded),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kRounded),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kRounded),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.04)),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(kRounded),
                              child: Container(
                                height: orientedCar
                                    ? deviceWidth / 3.0
                                    : deviceWidth / 3.0,
                                width: orientedCar
                                    ? deviceWidth / 1.5
                                    : deviceWidth / 1.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(kRounded),
                                ),
                                child: InkWell(
                                    borderRadius:
                                        BorderRadius.circular(kRounded),
                                    child: Center(
                                      child: Text(
                                        "DATA PRIVACY",
                                        style: TextStyle(
                                          inherit: false,
                                          fontFamily: "UrbanSB",
                                          fontSize: orientedCar
                                              ? deviceWidth / 18
                                              : deviceWidth / 18,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          maintainState: false,
                                          builder: (context) =>
                                              ChangeNotifierProvider<
                                                      Leprovider>(
                                                  create: (_) => Leprovider(),
                                                  child: Privacy()),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top:
                              orientedCar ? deviceWidth / 10 : deviceWidth / 8),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: orientedCar ? deviceWidth / 6 : deviceWidth / 6,
                        left: orientedCar ? deviceWidth / 6 : deviceWidth / 6,
                      ),
                      child: Column(
                        children: [
                          Text(
                            " \"${quotes.keys.toList()[randomNumber]}\" ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "RalewayR",
                                fontSize: orientedCar
                                    ? deviceWidth / 30
                                    : deviceWidth / 30),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "~${quotes.values.toList()[randomNumber]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "RalewayR ",
                                      fontSize: orientedCar
                                          ? deviceWidth / 32
                                          : deviceWidth / 32),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top:
                              orientedCar ? deviceWidth / 10 : deviceWidth / 8),
                    ),
                    Text(
                      "Copyright © 2020, Shaan Faydh",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "UrbanR",
                          fontSize: orientedCar
                              ? deviceWidth / 32
                              : deviceWidth / 32),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LicensesPage()),
                        );
                      },
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.white30)),
                      child: Text(
                        "Licenses",
                        style: TextStyle(
                          fontFamily: "UrbanR",
                          color: Colors.white,
                          fontSize:
                              orientedCar ? deviceWidth / 34 : deviceWidth / 34,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
