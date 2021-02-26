import 'package:feature_discovery/feature_discovery.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'Shaan.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'PHOENIX.dart';
import 'package:page_transition/page_transition.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

var myImage;
var firstafgodzilla;
var iriss;
int bratva = 0;
var skulldope;

class Homie extends StatefulWidget {
  createState() {
    return HomieState();
  }
}

class HomieState extends State<Homie> {
  String wodget = "NONE";
  var twice;
  var shot = 1.0;
  int duper = 0;
  int counter = 0;
  var isappliedcolor = const Color(0xFFCB0047);
  var yesornoicon = Icons.cancel;

  String eva;
  // String firstcall = getwidget();

  int icarus = 0;
  String apply = 'NOT APPLIED';
  @override
  Future<void> initState() {
    super.initState();
    myImage = Image.asset("lib/Start/phoenixphoenix.jpg");
    // anotherimage = Image.asset("lib/Start/blueneon2.png");

    setState(() {
      if (isiton == 1) {
        apply = "CARPE NOCTEM !";
        // isappliedcolor = const Color(0xFF009d41);
        isappliedcolor = const Color(0xFFCB0047);
        yesornoicon = Icons.check_circle;
      }
      FeatureDiscovery.discoverFeatures(
        context,
        const <String>{
          // Feature ids for every feature that you want to showcase in order.
          'add_item_feature_id',
        },
      );
    });
    //     skulldope = FlareActor('lib/Start/sizing.flr');
    // iriss = FlareActor('lib/Start/kg.flr');
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    godzilla = await getwidget();
    setState(() {
      afgodzilla = godzilla;
    });
    final assetProvider =
        AssetFlare(bundle: rootBundle, name: 'lib/Start/sizing.flr');
    await cachedActor(assetProvider);
    final hypeah =
        AssetFlare(bundle: rootBundle, name: 'lib/Start/attemix.flr');
    await cachedActor(hypeah);
    final buttonish = AssetFlare(bundle: rootBundle, name: 'lib/Start/kg.flr');
    await cachedActor(buttonish);
    precacheImage(myImage.image, context);
    // precacheImage(anotherimage.image, context);
    // print("doin.... sensitivity");
    double firstsensitivity = await getsensitivity();
    sensitivity = firstsensitivity;
    // print(sensitivity);

    setState(() {
      if (isiton == 1) {
        apply = "CARPE NOCTEM !";
        // isappliedcolor = const Color(0xFF009d41);
        isappliedcolor = const Color(0xFFCB0047);
        yesornoicon = Icons.check_circle;
      }
      // sensitivity = firstsensitivity;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(howmany);
    if (stormed == 1) {
      stormed = 2;
    }
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double fontZ = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 25,
        title: Text(
          "PHOENIX",
          style: TextStyle(fontFamily: 'InterR', fontSize: deviceHeight / 45),
        ),
        centerTitle: false,
        toolbarHeight: deviceHeight / 12,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/Start/starsedit.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              // child: GestureDetector(onPanUpdate: (details) {
              //   if (details.delta.dx > 0) {
              //     // swiping in right direction
              //     Navigator.push(
              //         context,
              //         PageTransition(
              //             type: PageTransitionType.fade,
              //             duration: Duration(milliseconds: 300),
              //             child: PHOENIX()));
              //   }
              //   if (details.delta.dx < 0) {
              //     Navigator.push(
              //         context,
              //         PageTransition(
              //             type: PageTransitionType.fade,
              //             duration: Duration(milliseconds: 300),
              //             child: Shaan()));
              //   }
              // }),
            ),

            Positioned(
              child: Align(
                alignment: Alignment(0, 0.95),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
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
                            color: Colors.white,
                            focusColor: Colors.redAccent,
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 200),
                                    child: PHOENIX()),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: deviceWidth / 2.5 / 3,
                          width: deviceWidth / 2.5 / 3,
                          child: IconButton(
                            iconSize: deviceWidth / 14,
                            tooltip: " HOME ",
                            padding: EdgeInsets.only(bottom: 1),
                            color: const Color(0xFFCB0047),
                            focusColor: Colors.redAccent,
                            icon: Icon(Icons.home),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          height: deviceWidth / 2.5 / 3,
                          width: deviceWidth / 2.5 / 3,
                          child: DescribedFeatureOverlay(
                            featureId:
                                'add_item_feature_id', // Unique id that identifies this overlay.
                            tapTarget: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.white,
                              size: deviceWidth / 14,
                            ), // The widget that will be displayed as the tap target.
                            title: Text('Navigating to Phoenix Setup'),
                            description: Text(
                                'Tap this icon or swipe right to go to the Phoenix Setup.'),
                            backgroundColor: const Color(0xFF160d2a),
                            targetColor: Colors.black45,
                            textColor: Colors.white,

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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

//First Box

            Wrap(
              runSpacing: deviceWidth / 25,
              children: [
                Center(),
                Center(),
                // Center(),
                // Positioned(
                Align(
                  alignment: Alignment(0, -0.9),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        if (details.delta.dx > 0) {
// swiping in right direction
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 300),
                                  child: PHOENIX()));
                        }
                        if (details.delta.dx < 0) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 300),
                                  child: Shaan()));
                        }
                      },
                      child: Container(
                        // margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                        height: deviceHeight / 3.9,
                        width: deviceWidth / 1.1,
                        color: Colors.black45,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                '$apply',
                                style: TextStyle(
                                  color: const Color(0xFFCB0047),
                                  fontSize: deviceWidth / 16,
                                  fontFamily: "NightMachine",
                                  shadows: [
                                    Shadow(
                                      blurRadius: 11.0,
                                      color: Colors.black38,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                icon: Icon(yesornoicon,
                                    size: deviceWidth / 12,
                                    color: isappliedcolor),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 300),
                                      child: Shaan(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Text(
                                '<         $afgodzilla         >',
                                style: TextStyle(
                                    fontFamily: "Fontz",
                                    fontWeight: FontWeight.w300,
                                    // fontSize: 16,

                                    fontSize: deviceHeight / 58,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(),

                Align(
                  alignment: Alignment(0, 0.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        if (details.delta.dx > 0) {
                          // swiping in right direction
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 300),
                                  child: PHOENIX()));
                        }
                        if (details.delta.dx < 0) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 300),
                                  child: Shaan()));
                        }
                      },
                      child: Container(
                        height: deviceHeight / 2.4,
                        width: deviceWidth / 1.1,
                        color: Colors.black45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(child: Text('')),
                            Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'PHOENIX         ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          // fontSize: 26,
                                          fontSize: deviceWidth / 16,
                                          fontFamily: "NightMachine",
                                          shadows: [
                                            Shadow(
                                              blurRadius: 11.0,
                                              color: Colors.black38,
                                              offset: Offset(5.0, 5.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: "NightMachine",
                                          shadows: [
                                            Shadow(
                                              blurRadius: 11.0,
                                              color: Colors.black38,
                                              offset: Offset(5.0, 5.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: "NightMachine",
                                          shadows: [
                                            Shadow(
                                              blurRadius: 11.0,
                                              color: Colors.black38,
                                              offset: Offset(5.0, 5.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

// Phoenix Para

                                  // Center(
                                  //   child: Text(
                                  //     '',
                                  //   ),
                                  // ),

                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: deviceWidth / 12,
                                          top: deviceWidth / 30,
                                          bottom: deviceWidth / 30),
                                      child: Text(
                                        "Phoenix is, and always will be, free for anyone. This project is all about me trying to be all that I've been dreaming of.",
                                        style: TextStyle(
                                            fontFamily: 'UrbanR',
                                            color: Colors.grey[350],
                                            fontSize: deviceWidth / 31
                                            // fontSize: 12
                                            // fontSize: deviceHeight / 62
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Center(
                            //   child: Text(
                            //     '',
                            //   ),
                            // ),
// YOUR
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(
                                      child: Text(
                                        '@SHΛΛИ FΛYDH',
                                        style: TextStyle(
                                          fontFamily: 'InterR',
                                          color: Colors.white,
                                          fontSize: deviceWidth / 30,
                                        ),
                                      ),
                                    ),
                                    Center(child: Text('')),
                                    Center(child: Text('')),
                                    Center(child: Text('')),
                                  ],
                                ),

//ICONS
                                // Center(child: Text('')),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(child: Text('')),
                                      Center(child: Text('')),
                                      IconButton(
                                          iconSize: deviceWidth / 17,
                                          icon: Icon(MdiIcons.instagram,
                                              color: Colors.white),
                                          onPressed: () {
                                            Instagram();
                                          }),
                                      IconButton(
                                          iconSize: deviceWidth / 17,
                                          icon: Icon(MdiIcons.discord,
                                              color: Colors.white),
                                          onPressed: () {
                                            Discord();
                                          }),
                                      IconButton(
                                          iconSize: deviceWidth / 17,
                                          icon: Icon(MdiIcons.gmail,
                                              color: Colors.white),
                                          onPressed: () {
                                            final Uri _emailLaunchUri = Uri(
                                                scheme: 'mailto',
                                                path:
                                                    'shaanfaydhphoenix@gmail.com',
                                                queryParameters: {
                                                  'subject':
                                                      'Sent-From-The-Phoenix'
                                                });
                                            launch(_emailLaunchUri.toString());
                                          }),
                                      IconButton(
                                          iconSize: deviceWidth / 17,
                                          icon: Icon(MdiIcons.linkedin,
                                              color: Colors.white),
                                          onPressed: () {
                                            Linkedin();
                                          }),
                                      IconButton(
                                          iconSize: deviceWidth / 17,
                                          icon: Icon(MdiIcons.github,
                                              color: Colors.white),
                                          onPressed: () async {
                                            Flushbar(
                                              backgroundColor: Colors.black87,
                                              message:
                                                  "The Github Repo is private as of now.",
                                              icon: Icon(Icons.lock_outlined,
                                                  size: 28.0,
                                                  color:
                                                      Colors.blueAccent[700]),
                                              isDismissible: true,
                                              dismissDirection:
                                                  FlushbarDismissDirection
                                                      .HORIZONTAL,
                                              duration: Duration(seconds: 5),
                                              margin: EdgeInsets.all(8),
                                              borderRadius: 8,
                                            )..show(context);
                                            await Future.delayed(
                                                const Duration(seconds: 3));
                                            Github();
                                          }),
                                      Center(child: Text('')),
                                      Center(child: Text('')),
                                      Center(child: Text('')),
                                      Center(child: Text('')),
                                      Center(child: Text('')),
                                      Center(child: Text('')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                '',
                              ),
                            ),

                            Center(
                              child: Text(
                                " -          KEEP FIGHTIN' GRAVITY           - ",
                                style: TextStyle(
                                    fontSize: deviceHeight / 65,
                                    fontFamily: 'InterR',
                                    color: Colors.grey[300]),
                              ),
                            ),
                            Center(child: Text('')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Instagram() async {
  const url = 'https://instagram.com/shaan_mephobic';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Linkedin() async {
  const url = 'https://www.linkedin.com/in/shaan-faydh-7b4b431b2/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Github() async {
  const url = 'https://github.com/shaan-mephobic?tab=repositories';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Discord() async {
  const url = 'https://discord.gg/m4EV7Xsrua';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
