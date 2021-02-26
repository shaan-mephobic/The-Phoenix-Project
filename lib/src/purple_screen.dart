import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'Shaan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io'
    show
        Directory,
        File,
        FileMode,
        FileSystemEntity,
        FileSystemEntityType,
        InternetAddress,
        Platform,
        SocketException,
        sleep;

import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';

import '../main.dart';
import 'Shaan.dart';
import 'app.dart';

// Color to give  options to
Color sel_1;
Color sel_2;
Color sel_3;
Color sel_4;
Color sel_5;
Color sel_6;

bool fuckmyeyes = false;

bool purple_disposed;

// Option 1
Color opt_1_1 = Color(0xFF582aa6);
Color opt_1_2 = Color(0xFF9b37f1);
Color opt_1_3 = Color(0xFFbb32f4);
Color opt_1_4 = Color(0xFFea63fd);
Color opt_1_5 = Color(0xFFf798fe);
Color opt_1_6 = Color(0xFFbf93f4);

// Option 2
Color opt_2_1 = Color(0xFFf7004a);
Color opt_2_2 = Color(0xFFad1052);
Color opt_2_3 = Color(0xFF4e92c2);
Color opt_2_4 = Color(0xFF364270);
Color opt_2_5 = Color(0xFF700750);
Color opt_2_6 = Color(0xFFffaa10);

// Option 3
Color opt_3_1 = Colors.redAccent[700];
Color opt_3_2 = Colors.blueAccent[400];
Color opt_3_3 = Colors.greenAccent[700];
Color opt_3_4 = Colors.tealAccent[700];
Color opt_3_5 = Colors.cyanAccent[400];
Color opt_3_6 = Colors.purpleAccent[700];

class Purplefook extends StatefulWidget {
  @override
  _PurplefookState createState() => _PurplefookState();
}

class _PurplefookState extends State<Purplefook> {
  @override
  Future<void> initState() {
    super.initState();
    purple_disposed = false;
    if (colorhandler == 2) {
      sel_1 = opt_1_1;
      sel_2 = opt_1_2;
      sel_3 = opt_1_3;
      sel_4 = opt_1_4;
      sel_5 = opt_1_5;
      sel_6 = opt_1_6;
      fuckmyeyes = true;
    } else if (colorhandler == 1) {
      sel_1 = opt_2_1;
      sel_2 = opt_2_2;
      sel_3 = opt_2_3;
      sel_4 = opt_2_4;
      sel_5 = opt_2_5;
      sel_6 = opt_2_6;
      fuckmyeyes = false;
    } else if (colorhandler == 3) {
      sel_1 = opt_3_1;
      sel_2 = opt_3_2;
      sel_3 = opt_3_3;
      sel_4 = opt_3_4;
      sel_5 = opt_3_5;
      sel_6 = opt_3_6;
      fuckmyeyes = false;
    }

    purple_canigetawhatwhat();
  }

  @override
  void dispose() {
    purple_disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: dynamocolor,
      ),
    );
  }

  purple_canigetawhatwhat() async {
    print("screen go brrr");
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String localPath =
        appDocPath + Platform.pathSeparator + 'darted_csv/darted.csv';
    final String alocalPath = appDocDir.path;

    double sleeping = 100;
    var everythin;

    print("YOU SEEING THIS SHIT!");

    String replacethat;

    // await FlutterRingtonePlayer.playRingtone();
    audiofilestored = await getaudiowidget();
    if (audiofilestored != '$alocalPath/Avengers-infinity-remix-RzM.mp3') {
      // print(audiofilestored);
      replacethat = audiofilestored.toString();
      replacethat = replacethat.replaceRange(0, 6, '');
      // print(replacethat);
      replacethat = replacethat.replaceRange(0, 1, '');
      replacethat = replacethat.substring(0, replacethat.length - 1);
      print(replacethat);
    } else {
      replacethat = audiofilestored.toString();
    }
    var anothervariable = 0;

    await audioPlayer.play(replacethat);

    stormed = 1;
    await ahboinkboink();

    var shaan;
    var dumbo;
    var listed;
    var line;
    var duplisted;
    List<double> saidtheskai = [];
    List<double> changethesky = [];
    var eachcolordif;
    List<double> extendlist = [
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0
    ];
    var highestval;
    var beeu;
    double judgeme;
    var drtime;
    double dork;
    if (audiofilestored != '$alocalPath/Avengers-infinity-remix-RzM.mp3') {
      shaan = await File(localPath).readAsString();
      dumbo = LineSplitter.split(shaan);

      listed = dumbo.toList();
      duplisted = dumbo.toList();
    } else {
      shaan = await rootBundle.loadString("lib/Start/avengers.csv");
      dumbo = LineSplitter.split(shaan);
      listed = dumbo.toList();
      duplisted = dumbo.toList();
    }
    print(listed.length);

//Creating a new list by parsing data as double

    List<double> countable = List();
    for (int i = 0; i < listed.length; i++) {
      double sighs = double.parse(listed[i]);
      changethesky.insert(i, sighs);
      if (duplisted[i] != "100.0") {
        judgeme = double.parse(duplisted[i]);
        countable.add(judgeme);
      }
    }

    countable.sort((b, a) => a.compareTo(b));

//highestval is the largest number

    highestval = countable.toList()[0];
    print(highestval);

//Multiplying list length by taking mean inbetween

    for (int i = 0; i < changethesky.length; i++) {
      if (i >= 1 && i < changethesky.length) {
        double extr = (changethesky[i] + changethesky[i - 1]) / 2;
        changethesky.insert(i, extr);
        i++;
      }
    }

//Multiplyin' again to make it 0.75/sec

    for (int i = 0; i < changethesky.length; i++) {
      if (i >= 1 && i < changethesky.length) {
        double intheend = (changethesky[i] + changethesky[i - 1]) / 2;
        changethesky.insert(i, intheend);
        i++;
      }
    }
    print(changethesky.length);
    eachcolordif = (highestval - globalshot) / 5;

//Multiplying again for a smoother frame
    for (int i = 0; i < changethesky.length; i++) {
      if (i >= 1 && i < changethesky.length) {
        double intheend = (changethesky[i] + changethesky[i - 1]) / 2;
        changethesky.insert(i, intheend);
        i++;
      }
    }
    print(changethesky.length);

// MAIN ALGORYTHM

    if (!fuckmyeyes) {
      outerloop:
      for (int i = 0; i < changethesky.length; i = i + 1) {
        line = changethesky[i];
        // print("$i - $line");
        dork = line;

        if (bratva == 1) {
          break outerloop;
        }
/*      
                  Debug

       print("globalshot is $globalshot");
       print("colordif is $eachcolordif");
       
*/

//brightest color
        if (dork < globalshot) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = sel_1;
            });
            // print("1 color");
          }
        }
//second brightest color
        else if (dork > globalshot &&
            dork < (globalshot + (eachcolordif / 4))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = sel_2;
            });
            // print("2 color");
          }
        }
//third brightest color
        else if (dork > (globalshot + (eachcolordif / 4)) &&
            dork < (globalshot + (eachcolordif / 3))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = sel_3;
            });
            // print("3 color");
          }
        }
//fourth brightest color
        else if (dork > (globalshot + (eachcolordif / 3)) &&
            dork < (globalshot + (eachcolordif / 2))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = sel_4;
            });
            // print("4 color");
          }
        }
//fifth brightest color
        else if (dork > (globalshot + (eachcolordif / 2)) &&
            dork < (globalshot + (eachcolordif))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = sel_5;
            });
            // print("5 color");
          }
        }
//everything black
        else if (dork > (globalshot + (eachcolordif))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = sel_6;
            });
            // print("6 color");
          }
        }
        await Future.delayed(const Duration(microseconds: 35000));

        if (purple_disposed) {
          await audioPlayer.stop();
          bratva = 1;
          play = 1;
        }
      }
    } else if (fuckmyeyes) {
      outerloop:
      for (int i = 0; i < changethesky.length; i = i + 1) {
        line = changethesky[i];
        // print("$i - $line");
        dork = line;

        if (bratva == 1) {
          break outerloop;
        }
/*      
                  Debug

       print("globalshot is $globalshot");
       print("colordif is $eachcolordif");
       
*/

//brightest color
        if (dork < globalshot) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFF880E4F);
            });
            // print("1 color");
          }
        }
//second brightest color
        else if (dork > globalshot &&
            dork < (globalshot + (eachcolordif / 8))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFAD1457);
            });
            // print("2 color");
          }
        }
//third brightest color
        else if (dork > (globalshot + (eachcolordif / 8)) &&
            dork < (globalshot + (eachcolordif / 7))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFC2185B);
            });
            // print("3 color");
          }
        }
//fourth brightest color
        else if (dork > (globalshot + (eachcolordif / 7)) &&
            dork < (globalshot + (eachcolordif / 6))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFD81B60);
            });
            // print("4 color");
          }
        }
//fifth brightest color
        else if (dork > (globalshot + (eachcolordif / 6)) &&
            dork < (globalshot + (eachcolordif / 5))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFE91E63);
            });
          }
        }
//sixth color
        else if (dork > (globalshot + (eachcolordif / 5)) &&
            dork < (globalshot + (eachcolordif / 4))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFEC407A);
            });
          }
        }
// seventh color
        else if (dork > (globalshot + (eachcolordif / 4)) &&
            dork < (globalshot + (eachcolordif / 3))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFF06292);
            });
          }
        }
//eight color
        else if (dork > (globalshot + (eachcolordif / 3)) &&
            dork < (globalshot + (eachcolordif / 2))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFF48FB1);
            });
          }
        }
//ninth color
        else if (dork > (globalshot + (eachcolordif / 2)) &&
            dork < (globalshot + (eachcolordif))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFF8BBD0);
            });
          }
        }
//tenth color
        else if (dork > (globalshot + (eachcolordif))) {
          if (!purple_disposed) {
            setState(() {
              dynamocolor = Color(0xFFFCE4EC);
            });
          }
        }
        await Future.delayed(const Duration(microseconds: 35000));

        if (purple_disposed) {
          await audioPlayer.stop();
          bratva = 1;
          play = 1;
        }
      }
    }

    print("unexp");
    await audioPlayer.stop();

    bratva = 0;
    play = 0;

    // Navigator.push(
    //     context,
    //     PageTransition(
    //         type: PageTransitionType.fade,
    //         duration: Duration(milliseconds: 100),
    //         child: Shaan()));
  }
}
