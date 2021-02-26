import 'dart:io';

import 'package:Phoenix/src/Shaan.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'src/app.dart';

var howmany;
var shaan;
var errorwidget;

int storedvibe;
var godzilla;
int counting;
var mydumuk;
var anotherimage;
int time;
void main() async {
  runApp(FeatureDiscovery(
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: Splashbabe())));
}

getwidget() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String widgetstring = preferences.getString('widgetstring') ??
      "AVENGERS: INFINITY WAR THEME REMIX - RZM";
  // print("givemethepussybouse");
  await getdrugs();
  await getringtoneext();
  await getquickreload();
  if (errorwidget == null) {
    errorwidget = widgetstring;
  }

  print(widgetstring);
  return widgetstring;
}

getaudiowidget() async {
  
  Directory appDocDir = await getApplicationDocumentsDirectory();
  final String alocalPath = appDocDir.path;

  SharedPreferences preferences = await SharedPreferences.getInstance();
  String audiostring = preferences.getString('audiostring') ??
      '$alocalPath/Avengers-infinity-remix-RzM.mp3';
  // print(audiostring);
  return audiostring;
}

getringtoneext() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String ringy = preferences.getString('ringext') ?? "NONE";
  // print("givemethepussybouse");
  subext = ringy;

  return ringy;
}

getsensitivity() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  double getsensitivityi = (preferences.getDouble('setsensitivity') ?? 3.0);
  // print(getsensitivityi);
  getdummy();

  return getsensitivityi;
}

getdummy() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int dummie = (preferences.getInt('dummie') ?? 0);
  // print(getsensitivityi);
  justanotherdummy = dummie;
  return dummie;
}

getquickreload() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int quicky = (preferences.getInt('hotreload') ?? 0);
  // print(getsensitivityi);
  quickreloader = quicky;
  return quicky;
}

gettime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int gettimes = (preferences.getInt('firsttime') ?? 0);
  // print(getsensitivityi);
  time = gettimes;
  if (time == 0) {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final String alocalPath = appDocDir.path;
    File nullfile = File('$alocalPath/Avengers-infinity-remix-RzM.mp3');
    final imageBytes =
        await rootBundle.load('assets/Avengers-infinity-remix-RzM.mp3');
    final buffer = imageBytes.buffer;
    await nullfile.writeAsBytes(
        buffer.asUint8List(imageBytes.offsetInBytes, imageBytes.lengthInBytes));
    print("setting up avengers");

    settime();
  }
  return gettimes;
}

settime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('firsttime', 1);
}

getdrugs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int getdrug = (preferences.getInt('druggedup') ?? 0);
  storedvibe = getdrug;

  return getdrug;
}

class Splashbabe extends StatefulWidget {
  @override
  _SplashbabeState createState() => _SplashbabeState();
}

class _SplashbabeState extends State<Splashbabe> {
  @override
  Future<void> initState() {
    super.initState();
    mydumuk = Image.asset("lib/Start/starsedit.jpg");
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // print("doin.... sensitivity");
    double firstsensitivity = await getsensitivity();
    sensitivity = firstsensitivity;
    // print(sensitivity);
    gettime();
    precacheImage(mydumuk.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splashIconSize: 350.0,
      splash: 'lib/Start/notoptimized.gif',
      duration: 3400,
      animationDuration: Duration(seconds: 1),
      backgroundColor: Colors.black,
      // curve: Curves.easeIn,
      screenFunction: () async {
        return Homie();
      },

      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
