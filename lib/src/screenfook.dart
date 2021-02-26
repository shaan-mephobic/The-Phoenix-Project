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

bool disposed;

class Screenfook extends StatefulWidget {
  @override
  _ScreenfookState createState() => _ScreenfookState();
}

class _ScreenfookState extends State<Screenfook> {
  @override
  Future<void> initState() {
    super.initState();
    disposed = false;
    SystemChrome.setEnabledSystemUIOverlays([]);
    canigetawhatwhat();
  }

  @override
  void dispose() {
    disposed = true;
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

  canigetawhatwhat() async {
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
      print(audiofilestored);
      replacethat = audiofilestored.toString();
      replacethat = replacethat.replaceRange(0, 6, '');

      replacethat = replacethat.replaceRange(0, 1, '');

      // print(replacethat);
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
    List<double> times = [];
    var beeu;
    var drtime;

    double dork;
    if (audiofilestored != '$alocalPath/Avengers-infinity-remix-RzM.mp3') {
      shaan = await File(localPath).readAsString();
      dumbo = LineSplitter.split(shaan);
      listed = dumbo.toList();
    } else {
      shaan = await rootBundle.loadString("lib/Start/avengers.csv");
      dumbo = LineSplitter.split(shaan);
      listed = dumbo.toList();
    }
    print(listed.length);
    // print(listed);
    for (int i = 0; i < listed.length; i++) {
      double sighs = double.parse(listed[i]);
      times.insert(i, sighs);
    }

    for (int i = 0; i < times.length; i++) {
      if (i >= 1 && i < times.length) {
        double extr = (times[i] + times[i - 1]) / 2;
        times.insert(i, extr);
        i++;
      }
    }
    // print(times);
    print(times.length);
    outerloop:
    for (var i = 0; i < times.length; i = i + 1) {
      line = times[i];
      // print(i);
      dork = line;

      if (bratva == 1) {
        break outerloop;
      }

      if (dork <= globalshot) {
        if (!disposed) {
          setState(() {
            dynamocolor = Colors.white;
          });

          // if (globalhayabusa == 1) {
          //   await Vibration.vibrate(duration: 300);
          // }
        }
      } else {
        if (!disposed) {
          setState(() {
            dynamocolor = Colors.black;
          });
        }
      }

      if (disposed) {
        await audioPlayer.stop();
        bratva = 1;
        play = 1;
      }
      await Future.delayed(const Duration(microseconds: 140000));
    }

    print("over");
    await audioPlayer.stop();

    bratva = 0;
    play = 0;
  }
}
