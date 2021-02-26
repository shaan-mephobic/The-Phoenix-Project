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
import 'dart:math';
import 'dart:typed_data';
import 'package:Phoenix/main.dart';
import 'package:Phoenix/src/purple_screen.dart';
import 'package:Phoenix/src/screenfook.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_state/extensions_static.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:torch_compat/torch_compat.dart';
import 'PHOENIX.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'app.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flare_flutter/flare.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vibration/vibration.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flare_loading/flare_loading.dart';

var duh;
var subext;
var handlerif = 0;
var quickreloader;
bool loader;
int colorhandler = 0;
String epilepticani = "dreams";
int stoppingaudio = 0;
String coloringopt = coloringlist[colorhandler];
int isiton;
int justanotherdummy;
List<String> coloringlist = [
  "Classic B&W",
  "Shadowave",
  "Cosmix",
  "Epilepstic Shock"
];
var passer;
double sensitivity;
var functionext;
int somewhe = 0;
IconData somewheicon = Icons.flip_camera_ios;
var movin;
Color dynamocolor = Colors.white;
double infin = 1000 / 3;
var unloading = 0;
var crywolf;
int errorwidgetcheck;
double anothersensitivity;
var extofsong;
bool notlist;
int forsensitivity = 0;
var displayTime;
bool sensitivityanimation = true;
var snackBar;
var DEVICEWIDTH;
var DEVICEHEIGHT;
int brakes = 0;
var bitchhowmany = 'NONE';
String owee;
double globalshot;
int globalhayabusa;
var audiofilestored;
var afgodzilla;
var pltpa = 'PLAYTOPAUSE';
var patpl = 'PAUSETOPLAY';
var currentanimation = 'START';
int drug;
int callbreaker = 0;
var switchmuch = 0;

var stormed = 0;
int bgservice;
int panik;
var switchimation;
int play = 0;
var filica;
List<bool> selections = List.generate(1, (_) => false);
int wicked = 1;
// var currentanimation;
final RoundedLoadingButtonController _btnController =
    new RoundedLoadingButtonController();
var stopp = _btnController;

enum PhonecallState { incoming, dialing, connected, disconnected, none }
enum PhonecallStateError { notimplementedyet }
AudioPlayer audioPlayer = AudioPlayer();

class Shaan extends StatefulWidget {
  createState() {
    return Shaanstate();
  }
}

class Shaanstate extends State<Shaan> {
  FlutterLocalNotificationsPlugin fltrNotification;

  var phonecallstatuslog;
  var theotherone;
  var lastAct;
  var Colorviber;
  int notivar;
  var tempstr;
  var dreem;
  var pathica;
  int hayabusa = 0;
  double shot = 0;
  String dummy = "";
  var switchmuch = 0;
  var switchimation = 'START';
  var persi;
  String temp = '';

  final _stopWatchTimer = StopWatchTimer(onChange: (value) {
    displayTime = StopWatchTimer.getDisplayTime(value);
  });
  List<double> maindata = [];
  var vegan = '';

  Color icun = Colors.grey[300];
  // Color totcolor = Color(0xFF009688);
  Color totcolor = Color(0xFFCB0047);
  int grad = 0;
  String sinatra = '  S  E  L  E  C  T  ? ';

  var player = 'None';

  String wodget = 'None';

  int counter = 0;
  String bootun = 'Choose That Mofo';
  // Phonecallstate phonecallstate;
  PhonecallState phonecallstatus;

  Future<void> initState() {
    print("time is $time");

    super.initState();
    if (isiton == 1) {
      switchimation = 'On';
      setState(() {
        switchimation = 'On';
        wicked = 0;
        switchmuch = 1;
      });
    }
    if (play == 1) {
      currentanimation = pltpa;
    }
    var androidInitialize =
        new AndroidInitializationSettings('notification_phoenix');
    var iOSinitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSinitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationsSettings,
        onSelectNotification: notificationSelected);
    drug = storedvibe;
    if (drug == 0) {
      Colorviber = Colors.blueGrey;
    } else if (drug == 1) {
      Colorviber = Colors.white;
      hayabusa = 1;
      globalhayabusa = 1;
    }
    if (forsensitivity == 1) {
      sensitivityanimation = false;
    }

    FeatureDiscovery.discoverFeatures(context, const <String>{
      // Feature ids for every feature that you want to showcase in order.
      'add_item_feature_daemon',
      'add_item_feature_call',
      'add_item_feature_play',
    });
    if (stormed == 2) {
      crumbling();
    }
  }
  // @override
  // void didChangeDependencies() async {
  //   print("doin.... sensitivity");
  //   super.didChangeDependencies();
  //   var firstsensitivity = await getsensitivity();

  //   setState(() {
  //     sensitivity = firstsensitivity as double;
  //   });
  // }
  _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        'Channel ID', 'THE PHOENIX', "THE PHOENIX IS AWAKE",
        importance: Importance.low,
        showWhen: false,
        visibility: NotificationVisibility.secret,
        enableVibration: false,
        playSound: false,
        channelShowBadge: false,
        enableLights: false,
        ongoing: true,
        priority: Priority.low,
        color: const Color(0xFFCB0047));
    var IOSDetailes = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: IOSDetailes);

    await fltrNotification.show(
        0, "THE PHOENIX IS AWAKE!", "Carpe Noctem", generalNotificationDetails);
  }

  _boNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        'Channel ID', 'THE PHOENIX', "THE PHOENIX IS AWAKE",
        importance: Importance.low,
        showWhen: false,
        timeoutAfter: 500,
        visibility: NotificationVisibility.secret,
        enableVibration: false,
        channelShowBadge: false,
        enableLights: false,
        playSound: false,
        ongoing: false,
        priority: Priority.low,
        color: const Color(0xFFCB0047));
    var IOSDetailes = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: IOSDetailes);

    await fltrNotification.show(0, "THE PHOENIX WAS KILLED",
        "Keep Fightin' Gravity", generalNotificationDetails);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (subext != "NONE") {
      extofsong = subext;
    }
    if (disposed == false) {
      print("reach");
      setState(() {
        currentanimation = patpl;
      });
      bratva = 0;
      play = 0;
    }
    if (purple_disposed == false) {
      print("reach");
      setState(() {
        currentanimation = patpl;
      });
      bratva = 0;
      play = 0;
    }

    if (justanotherdummy == 0) {
      // RingtoneSet.setRingtone("Avengers-infinity-remix-RzM.mp3");
      PermPerm();
      setdummy();
      vettimundo();
    }

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    DEVICEWIDTH = deviceWidth;
    DEVICEHEIGHT = deviceHeight;
    double textsize = MediaQuery.of(context).textScaleFactor;

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
                  image: AssetImage("lib/Start/starsedit.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              // child: GestureDetector(onPanUpdate: (details) {
              //   if (details.delta.dx > 0) {
              //     // swiping in right direction
              //     Navigator.push(
              //       context,
              //       PageTransition(
              //           type: PageTransitionType.fade,
              //           duration: Duration(milliseconds: 300),
              //           child: Homie()),
              //     );
              //   }
              //   if (details.delta.dx < 0) {}
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
                            padding: EdgeInsets.only(bottom: 1),
                            iconSize: deviceWidth / 14,
                            color: Colors.white,
                            focusColor: Colors.redAccent,
                            icon: Icon(Icons.info_outline),
                            tooltip: "PHOENIX",
                            // iconSize: deviceHeight / 28,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: PHOENIX(),
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 200),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: deviceWidth / 2.5 / 3,
                          width: deviceWidth / 2.5 / 3,
                          child: IconButton(
                            iconSize: deviceWidth / 14,
                            padding: EdgeInsets.only(bottom: 1),
                            color: Colors.white,
                            focusColor: Colors.redAccent,
                            icon: Icon(Icons.home_outlined),
                            tooltip: "HOME",
                            // iconSize: deviceHeight / 28,
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
                            padding: EdgeInsets.only(bottom: 1),
                            color: const Color(0xFFCB0047),
                            focusColor: Colors.redAccent,
                            icon: Icon(Icons.play_arrow),
                            tooltip: "PHOENIX SETUP",
                            // iconSize: deviceHeight / 28,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

//        the bg container

            Positioned(
              child: Align(
                alignment: Alignment(0, -0.5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dx > 0) {
                        // swiping in right direction
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 300),
                              child: Homie()),
                        );
                      }
                      if (details.delta.dx < 0) {}
                    },
                    child: Container(
                      // margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                      height: deviceHeight / 1.4,
                      width: deviceWidth / 1.12,
                      color: Colors.black26,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
// PHOENIX SETUP

                          Container(
                            padding: EdgeInsets.only(top: deviceHeight / 100),
                            child: Center(
                              child: Text(
                                'PHOENIX  SETUP',
                                style: TextStyle(
                                  color: Colors.white,
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
                          ),

// THE PICKERRoundedLoadingButton(
                          //   child: Text('Tap me!', style: TextStyle(color: Colors.white)),
                          //   controller: _btnController,
                          //   onPressed: _doSomething,
                          //   width: 200,
                          // ),

                          Container(
                            child: DescribedFeatureOverlay(
                              featureId:
                                  'add_item_feature_daemon', // Unique id that identifies this overlay.
                              tapTarget: Text('S E L E C T',
                                  style: TextStyle(
                                    fontSize: deviceHeight / 44,
                                    color: totcolor,
                                    fontFamily: 'Fontz',
                                  )),
                              // The widget that will be displayed as the tap target.
                              title: Text('What does "SELECT" do?'),
                              description: Text(
                                  'With this you can select \nyour songs to play as Phoenix.'),
                              backgroundColor: const Color(0xFF160d2a),
                              targetColor: Colors.transparent,
                              textColor: Colors.white,
                              child: RoundedLoadingButton(
                                elevation: 3.0,
                                width: deviceHeight / 6,
                                height: deviceHeight / 20,
                                color: Colors.transparent,
                                child: Text('S E L E C T',
                                    style: TextStyle(
                                      fontSize: deviceHeight / 42,
                                      color: totcolor,
                                      fontFamily: 'Fontz',
                                    )),
                                controller: _btnController,
                                onPressed: () async {
                                  if (wicked == 0 && switchmuch == 1) {
                                    print("Going down for real");
                                    setState(() {
                                      switchimation = 'Off';
                                      // bgservice = 0;
                                      isiton = 0;
                                      panik = 1;
                                    });
                                    _boNotification();

                                    print("Turned off");
                                    wicked = 1;

                                    switchmuch = 0;
                                  }

                                  try {
                                    final result = await InternetAddress.lookup(
                                        'google.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      print('connected');
                                      var appDir =
                                          (await getTemporaryDirectory()).path;
                                      new Directory(appDir)
                                          .delete(recursive: true);
                                      print("cleared-cache");
                                      var updatedbug = await FilePicker.platform
                                          .pickFiles(
                                              withData: true,
                                              allowCompression: true,
                                              type: FileType.audio);
                                      print("begin");
                                      if (updatedbug == null) {
                                        _btnController.reset();
                                        Flushbar(
                                          backgroundColor: Colors.black87,
                                          message: "WELL, ITS YOUR LOSS",
                                          icon: Icon(
                                            Icons.sentiment_satisfied,
                                            size: 28.0,
                                            color: const Color(0xFFCB0047),
                                          ),
                                          isDismissible: true,
                                          dismissDirection:
                                              FlushbarDismissDirection
                                                  .HORIZONTAL,
                                          duration: Duration(seconds: 5),
                                          margin: EdgeInsets.all(8),
                                          borderRadius: 8,
                                        )..show(context);
                                        howmany = "NONE";
                                        await setwidget();
                                        setState(() {
                                          afgodzilla = "NONE";
                                        });
                                      }

                                      try {
                                        File file =
                                            File(updatedbug.files.single.path);
                                        print(file);
                                        movin = file;
                                        pathica = updatedbug.files.single.path;
                                        print("the causer $pathica");
                                        extofsong =
                                            updatedbug.files.single.extension;
                                        print("better off lonely $extofsong");
                                        if (!pathica.contains(".jpg") &&
                                            !pathica.contains(".mp4") &&
                                            !pathica.contains(".pdf") &&
                                            !pathica.contains(".jpeg") &&
                                            !pathica.contains(".png") &&
                                            !pathica.contains(".doc") &&
                                            !pathica.contains(".txt") &&
                                            !pathica.contains(".gif") &&
                                            !pathica.contains(".avi") &&
                                            !pathica.contains(".rar") &&
                                            !pathica.contains(".zip") &&
                                            !pathica.contains(".mpg") &&
                                            !pathica.contains(".mpeg") &&
                                            !pathica.contains(".svg") &&
                                            !pathica.contains(".csv") &&
                                            !pathica.contains(".ini") &&
                                            !pathica.contains(".xlsx") &&
                                            !pathica.contains(".docx") &&
                                            !pathica.contains(".dng") &&
                                            !pathica.contains(".raw") &&
                                            !pathica.contains(".py") &&
                                            !pathica.contains(".css") &&
                                            !pathica.contains(".html") &&
                                            !pathica.contains(".cpp") &&
                                            !pathica.contains(".dart") &&
                                            !pathica.contains(".ppt") &&
                                            !pathica.contains(".pptx") &&
                                            !pathica.contains(".eps") &&
                                            !pathica.contains(".sys") &&
                                            !pathica.contains(".tif") &&
                                            !pathica.contains(".exe") &&
                                            !pathica.contains(".odt") &&
                                            !pathica.contains(".ogg")) {
                                          owee = file.toString();
                                          String insteadowee = 'kundi$owee';
                                          print(insteadowee);
                                          String bootun2;
                                          print('fucking$owee');
                                          final original = '$owee';
                                          //player = file;
                                          final find =
                                              "/data/user/0/com.Phoenix.project/cache/file_picker/";
                                          final replaceWith = '';
                                          String buttonName = original
                                              .replaceAll(find, replaceWith);
                                          print('$buttonName');
                                          String remove =
                                              buttonName.replaceRange(0, 7, '');
                                          print('getready$remove');
                                          print('hogaya?-----$remove');
                                          bootun = remove;

                                          // final dickshit = buttonName;
                                          // final finding = 'File: ';
                                          // final replaceWither = '';
                                          // final dickshit2 =
                                          //     dickshit.replaceAll(finding, replaceWither);
                                          // bootun = dickshit2;
                                          // print(' this remove it $dickshit');

                                          if (bootun.contains('.mp3')) {
                                            String tempi = buttonName
                                                .replaceRange(0, 7, '');
                                            final mp3 = tempi;
                                            final findings = ".mp3'";
                                            final replacer = '';
                                            final mp3es = mp3.replaceAll(
                                                findings, replacer);
                                            print(mp3es);
                                            print("above");
                                            bootun2 = mp3es;
                                          }

                                          if (bootun.contains('.wav')) {
                                            String tempi = buttonName
                                                .replaceRange(0, 7, '');
                                            final waver = tempi;
                                            final findingwav = ".wav'";
                                            final replacewav = '';
                                            final wavers = waver.replaceAll(
                                                findingwav, replacewav);
                                            bootun2 = wavers;
                                            print(bootun2);
                                          }

                                          if (bootun.contains('.flac')) {
                                            String tempi = buttonName
                                                .replaceRange(0, 7, '');
                                            final flac = tempi;
                                            final findingslac = ".flac'";
                                            final replacerlac = '';
                                            final flacer = flac.replaceAll(
                                                findingslac, replacerlac);
                                            bootun2 = flacer;
                                          }

                                          if (bootun.contains('.aac')) {
                                            String tempi = buttonName
                                                .replaceRange(0, 7, '');

                                            final aacer = tempi;
                                            final findingsaac = ".aac'";
                                            final replaceraac = '';
                                            final aacers = aacer.replaceAll(
                                                findingsaac, replaceraac);
                                            bootun2 = aacers;
                                          }

                                          if (bootun.contains('.m4a')) {
                                            String tempi = buttonName
                                                .replaceRange(0, 7, '');
                                            final m4er = tempi;
                                            final findingm4a = ".m4a'";
                                            final replacem4a = '';
                                            final m4ers = m4er.replaceAll(
                                                findingm4a, replacem4a);
                                            bootun2 = m4ers;
                                          }
                                          Directory appDocDir =
                                              await getApplicationDocumentsDirectory();

                                          sinatra = '  A w e s o m e !   ';
                                          grad++;
                                          if (bootun2 == null) {
                                            wodget = remove.substring(
                                                0, remove.length - 1);
                                          } else {
                                            wodget = bootun2;
                                          }

                                          duh = wodget;
                                          howmany = wodget;
                                          print('mamamamamamamamamama$wodget');
                                          await setwidget();
                                          await setaudio();
                                          await setringtoneext();

                                          godzilla = await getwidget();
                                          print(godzilla);
                                          afgodzilla = godzilla;
                                          print('mamamamamamamamamama$wodget');

                                          final icun = Colors.white;
                                          // totcolor = Color(0xFF00e676);
                                          if (brakes == 0) {
                                            initializer();
                                          }
                                          loader = true;

                                          upload(file);
                                          setState(
                                            () {
                                              afgodzilla = godzilla;
                                              handlerif = 1;
                                              print(afgodzilla);
                                              counter++;
                                            },
                                          );
                                        } else {
                                          Flushbar(
                                            backgroundColor: Colors.black87,
                                            message: "Select An Audio File!",
                                            icon: Icon(
                                              Icons.cancel,
                                              size: 28.0,
                                              color: Colors.red,
                                            ),
                                            isDismissible: true,
                                            dismissDirection:
                                                FlushbarDismissDirection
                                                    .HORIZONTAL,
                                            duration: Duration(seconds: 5),
                                            margin: EdgeInsets.all(8),
                                            borderRadius: 8,
                                          )..show(context);

                                          var appDir =
                                              (await getTemporaryDirectory())
                                                  .path;
                                          new Directory(appDir)
                                              .delete(recursive: true);
                                          print("cleared-cache");
                                          howmany = "NONE";
                                          await setwidget();
                                          setState(() {
                                            afgodzilla = "NONE";
                                          });
                                          print(
                                              "EXCEPTION: Unselect Cuz You Know Why");

                                          _btnController.error();
                                          await Future.delayed(
                                              Duration(seconds: 5));
                                          _btnController.reset();
                                        }
                                      } catch (e) {
                                        if (updatedbug == null) {
                                        } else {
                                          _btnController.error();
                                          await Future.delayed(
                                              Duration(seconds: 5));
                                          _btnController.reset();
                                          Flushbar(
                                            backgroundColor: Colors.black87,
                                            message: "THERE WAS SOME ERROR",
                                            icon: Icon(
                                              Icons.cancel,
                                              size: 28.0,
                                              color: Colors.red,
                                            ),
                                            isDismissible: true,
                                            dismissDirection:
                                                FlushbarDismissDirection
                                                    .HORIZONTAL,
                                            duration: Duration(seconds: 5),
                                            margin: EdgeInsets.all(8),
                                            borderRadius: 8,
                                          )..show(context);
                                        }
                                      }
                                    }
                                  } on SocketException catch (_) {
                                    print('not connected');
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Container(
                                                color: Colors.transparent,
                                                child: FlareLoading(
                                                  height: DEVICEWIDTH / 1.5,
                                                  width: DEVICEWIDTH / 1.5,
                                                  startAnimation: 'no_netwrok',
                                                  loopAnimation: 'no_netwrok',
                                                  name:
                                                      'lib/Start/darkmodewoman.flr',
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.contain,
                                                  onError: (_, stacktrace) {},
                                                  onSuccess: (_) {},
                                                )));

                                    // _btnController.success();

                                    _btnController.error();
                                    await Future.delayed(Duration(seconds: 10));
                                    _btnController.reset();
                                  }
                                },
                              ),
                            ),
                          ),

//THE VIBRATION

                          // child: ToggleButtons(
                          //   children: [
                          //     Icon(
                          //       Icons.vibration,
                          //       size: deviceWidth / 12,
                          //     ),
                          //   ],
                          //   isSelected: selections,
                          //   color: Colors.blueGrey,
                          //   selectedColor: Colors.white,
                          //   fillColor: Colors.transparent,
                          //   borderColor: Colors.transparent,
                          //   onPressed: (int index) {
                          //     print("this is $selections");
                          //     setState(() {
                          //       selections[index] = !selections[index];
                          //     });
                          //     if (selections[index] == true) {
                          //       print('booyah');
                          //       notlist = false;
                          //       hayabusa = 1;
                          //       globalhayabusa = 1;
                          //     }
                          //     if (selections[index] == false) {
                          //       print("booof");
                          //       hayabusa = 0;
                          //       notlist = true;
                          //       globalhayabusa = 0;
                          //     }
                          //     setboolie();
                          //   },
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // GestureDetector(
                              //     onTapUp: (_) async {
                              //       if (drug == 0) {
                              //         hayabusa = 1;
                              //         globalhayabusa = 1;
                              //         drug++;
                              //         setdrugs();
                              //         setState(() {
                              //           Colorviber = Colors.white;
                              //         });
                              //       } else if (drug == 1) {
                              //         hayabusa = 0;
                              //         globalhayabusa = 0;
                              //         drug--;
                              //         setdrugs();
                              //         setState(() {
                              //           Colorviber = Colors.blueGrey;
                              //         });
                              //       }
                              //     },
                              //     child: Icon(Icons.vibration_rounded,
                              //         size: deviceWidth / 12,
                              //         color: Colorviber)),
                              GestureDetector(
                                onTapUp: (_) async {
                                  if (somewhe == 0) {
                                    somewheicon = Icons.clear_all;
                                    somewhe = 1;
                                    setState(() {});
                                  } else if (somewhe == 1) {
                                    somewheicon = Icons.flip_camera_ios;
                                    somewhe = 0;
                                    setState(() {});
                                  }
                                },
                                onLongPress: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (ctxt) => Container(
                                      padding: EdgeInsets.only(
                                          top: deviceWidth / 5,
                                          bottom: deviceWidth / 5,
                                          left: deviceWidth / 12,
                                          right: deviceWidth / 12),
                                      color: Colors.transparent,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Container(
                                          height: deviceWidth,
                                          width: deviceWidth / 1.6,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              FlareLoading(
                                                height: DEVICEWIDTH / 1.5,
                                                width: DEVICEWIDTH / 1.5,
                                                startAnimation: 'dreams',
                                                loopAnimation: 'dreams',
                                                name: 'lib/Start/attemix.flr',
                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                                onError: (_, stacktrace) {},
                                                onSuccess: (_) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  somewheicon,
                                  color: Colors.white,
                                  size: deviceWidth / 12,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.settings_sharp,
                                  color: Colors.white,
                                  size: deviceWidth / 13,
                                ),
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder:
                                            (context, StateSetter setState) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: deviceWidth / 5,
                                                bottom: deviceWidth / 5,
                                                left: deviceWidth / 12,
                                                right: deviceWidth / 12),
                                            color: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Container(
                                                height: deviceWidth,
                                                width: deviceWidth / 1.6,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: DEVICEWIDTH / 1.5,
                                                      width: DEVICEWIDTH / 1.5,
                                                      child: FlareActor(
                                                        'lib/Start/attemix.flr',
                                                        animation: epilepticani,
                                                        alignment:
                                                            Alignment.center,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Colors.white,
                                                      height: deviceWidth / 10,
                                                    ),

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        GestureDetector(
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                              height:
                                                                  deviceWidth /
                                                                      10,
                                                              width:
                                                                  deviceWidth /
                                                                      10,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text("<",
                                                                  style: TextStyle(
                                                                      inherit:
                                                                          false,
                                                                      fontFamily:
                                                                          "Fontz",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          deviceWidth /
                                                                              20,
                                                                      color: Colors
                                                                          .black)),
                                                            ),
                                                            onTap: () {
                                                              print("Lefty");
                                                              setState(() {
                                                                if (colorhandler ==
                                                                    1) {
                                                                  colorhandler =
                                                                      0;
                                                                  epilepticani =
                                                                      "dreams";
                                                                } else if (colorhandler ==
                                                                    2) {
                                                                  colorhandler =
                                                                      1;
                                                                  epilepticani =
                                                                      "shadowave";
                                                                } else if (colorhandler ==
                                                                    3) {
                                                                  colorhandler =
                                                                      2;
                                                                  epilepticani =
                                                                      "cosmix";
                                                                } else if (colorhandler ==
                                                                    0) {
                                                                  colorhandler =
                                                                      3;
                                                                  epilepticani =
                                                                      "epilepsy";
                                                                }
                                                                coloringopt =
                                                                    coloringlist[
                                                                        colorhandler];
                                                              });
                                                            }),
                                                        Text(
                                                          '$coloringopt',
                                                          style: TextStyle(
                                                              inherit: false,
                                                              fontFamily:
                                                                  "Fontz",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              // fontSize: 16,

                                                              fontSize:
                                                                  deviceWidth /
                                                                      25,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        GestureDetector(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              color:
                                                                  Colors.white,
                                                              height:
                                                                  deviceWidth /
                                                                      10,
                                                              width:
                                                                  deviceWidth /
                                                                      10,
                                                              child: Text(
                                                                ">",
                                                                style: TextStyle(
                                                                    inherit:
                                                                        false,
                                                                    fontFamily:
                                                                        "Fontz",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        deviceWidth /
                                                                            20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              print("righty");
                                                              setState(() {
                                                                if (colorhandler ==
                                                                    1) {
                                                                  colorhandler =
                                                                      2;
                                                                  epilepticani =
                                                                      "cosmix";
                                                                } else if (colorhandler ==
                                                                    2) {
                                                                  colorhandler =
                                                                      3;
                                                                  epilepticani =
                                                                      "epilepsy";
                                                                } else if (colorhandler ==
                                                                    3) {
                                                                  colorhandler =
                                                                      0;
                                                                  epilepticani =
                                                                      "dreams";
                                                                } else if (colorhandler ==
                                                                    0) {
                                                                  colorhandler =
                                                                      1;
                                                                  epilepticani =
                                                                      "shadowave";
                                                                }
                                                                coloringopt =
                                                                    coloringlist[
                                                                        colorhandler];
                                                              });
                                                            }),
                                                      ],
                                                    ),
                                                    // Center(
                                                    //   // mainAxisAlignment:
                                                    //   //     MainAxisAlignment
                                                    //   //         .spaceEvenly,
                                                    //   // children: [
                                                    //   child: Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment.center,
                                                    //     children: [
                                                    //       Container(
                                                    //         height: deviceWidth / 14,
                                                    //         width: deviceWidth / 14,
                                                    //         decoration: BoxDecoration(
                                                    //           boxShadow: [
                                                    //             BoxShadow(
                                                    //                 blurRadius: 10,
                                                    //                 color: Colors
                                                    //                     .black26,
                                                    //                 offset:
                                                    //                     Offset(1, 1))
                                                    //           ],
                                                    //           color: Colors.black,
                                                    //           border: Border(
                                                    //               left: BorderSide(
                                                    //                   width: 1.5,
                                                    //                   color: Colors
                                                    //                       .black),
                                                    //               top: BorderSide(
                                                    //                 color:
                                                    //                     Colors.black,
                                                    //                 width: 1.5,
                                                    //               ),
                                                    //               bottom: BorderSide(
                                                    //                 width: 1.5,
                                                    //                 color:
                                                    //                     Colors.black,
                                                    //               )),
                                                    //         ),
                                                    //       ),
                                                    //       Container(
                                                    //         height: deviceWidth / 14,
                                                    //         width: deviceWidth / 14,
                                                    //         decoration: BoxDecoration(
                                                    //           boxShadow: [
                                                    //             BoxShadow(
                                                    //                 blurRadius: 10,
                                                    //                 color: Colors
                                                    //                     .black26,
                                                    //                 offset:
                                                    //                     Offset(1, 1))
                                                    //           ],
                                                    //           color: Colors.white,
                                                    //           border: Border(
                                                    //               right: BorderSide(
                                                    //                   width: 1.5,
                                                    //                   color: Colors
                                                    //                       .black),
                                                    //               top: BorderSide(
                                                    //                 color:
                                                    //                     Colors.black,
                                                    //                 width: 1.5,
                                                    //               ),
                                                    //               bottom: BorderSide(
                                                    //                 width: 1.5,
                                                    //                 color:
                                                    //                     Colors.black,
                                                    //               )),
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // Container(
                                                    //   height: deviceWidth / 14,
                                                    //   width: deviceWidth / 14,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),

//THE SENSITIVITY

                          Center(
                            child: SleekCircularSlider(
                              appearance: CircularSliderAppearance(
                                animationEnabled: sensitivityanimation,
                                infoProperties: InfoProperties(
                                  bottomLabelStyle: TextStyle(
                                    fontFamily: 'InterR',
                                    color: const Color(0xFFF1F1F1),
                                    fontSize: deviceHeight / 60,
                                    // fontWeight: FontWeight.w600
                                  ),
                                  bottomLabelText: 'SENSITIVITY',
                                  mainLabelStyle: TextStyle(
                                      fontFamily: 'InterR',
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: deviceHeight / 40,
                                      fontWeight: FontWeight.w400),
                                  modifier: (double value) {
                                    final temp = value;
                                    var tomp = temp * 10;
                                    var timp = tomp.toInt();
                                    return '$timp';
                                  },
                                ),
                                size: deviceHeight / 6,
                                customColors:
                                    CustomSliderColors(progressBarColors: [
                                  // const Color(0xFF34e89e),
                                  // const Color(0xFF0f3443),
                                  const Color(0xFFa1277c),
                                  const Color(0xFF3c1439),
                                  const Color(0xFF160d2a),
                                ]),
                                customWidths: CustomSliderWidths(
                                    progressBarWidth: deviceWidth / 65),
                              ),
                              min: 0,
                              max: 10.0,
                              initialValue: sensitivity,
                              onChange: (double value) async {
                                forsensitivity = 1;
                                // print(value);
                                shot = value;
                                anothersensitivity = value;
                                setsensitivity();
                                globalshot = shot;
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
//PHONESTATE

                              Center(
                                child: DescribedFeatureOverlay(
                                  featureId:
                                      'add_item_feature_call', // Unique id that identifies this overlay.
                                  tapTarget: Container(
                                    width: deviceWidth / 6,
                                    height: deviceWidth / 10,
                                    child: FlareActor('lib/Start/kg.flr',
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        animation: switchimation),
                                  ),
                                  // The widget that will be displayed as the tap target.
                                  title: Text('Set Phoenix for ringtone?'),
                                  description: Text(
                                      'Tap this if you want your \nringtone to work as Phoenix'),
                                  backgroundColor: const Color(0xFF160d2a),
                                  targetColor: Colors.transparent,
                                  textColor: Colors.white,
                                  child: GestureDetector(
                                    onTapUp: (_) async {
                                      print('switched');
                                      if (wicked == 1) {
                                        if (switchmuch == 0) {
                                          Directory appDocDir =
                                              await getApplicationDocumentsDirectory();
                                          final String alocalPath =
                                              appDocDir.path;
                                          dreem = alocalPath;

                                          audiofilestored =
                                              await getaudiowidget();
                                          crywolf = 1;
                                          if (audiofilestored ==
                                                  '$alocalPath/Avengers-infinity-remix-RzM.mp3' &&
                                              Platform.isAndroid &&
                                              handlerif == 0) {
                                            print("STOCK RINGTONE BAE");

                                            await M3rcurial();
                                            Setty();

                                            // Flushbar(
                                            //   backgroundColor: Colors.black87,
                                            //   message:
                                            //       "Your Ringtone has been changed.",
                                            //   icon: Icon(
                                            //     Icons.music_note,
                                            //     size: 28.0,
                                            //     color: const Color(0xFFa1277c),
                                            //   ),
                                            //   isDismissible: true,
                                            //   dismissDirection:
                                            //       FlushbarDismissDirection
                                            //           .HORIZONTAL,
                                            //   duration: Duration(seconds: 5),
                                            //   margin: EdgeInsets.all(8),
                                            //   borderRadius: 8,
                                            // )..show(context);
                                            setState(() {
                                              switchimation = 'On';
                                              // Wakelock.enable();
                                              isiton = 1;
                                              panik = 0;
                                              switchmuch += 1;
                                              // bgservice = 1;
                                            });

                                            _watchAllPhoneCallEvents();

                                            _showNotification();

                                            // await kakaPhonecallstate();

                                            wicked -= 1;
                                            print("shouldnt print");
                                          } else if (handlerif == 1 ||
                                              audiofilestored !=
                                                  '$alocalPath/Avengers-infinity-remix-RzM.mp3') {
                                            print("CUSTOM RINGTONE BAE");
                                            // if (quickreloader != 0) {
                                            print("Not the first time huh");
                                            dleta();
                                            await bowler();
                                            Setty();

                                            setState(() {
                                              switchimation = 'On';
                                              // Wakelock.enable();
                                              isiton = 1;
                                              panik = 0;
                                              switchmuch += 1;
                                              // bgservice = 1;
                                            });

                                            _watchAllPhoneCallEvents();

                                            _showNotification();

                                            // await kakaPhonecallstate();

                                            wicked -= 1;
                                            print("shouldnt print");
                                            // }

                                            // if (quickreloader == 0) {
                                            //   print("first tim ehuh");
                                            //   Flushbar(
                                            //     backgroundColor: Colors.black87,
                                            //     message:
                                            //         "This Needs A Quick Reload",
                                            //     icon: Icon(
                                            //       Icons.home,
                                            //       size: 28.0,
                                            //       color:
                                            //           const Color(0xFFCB0047),
                                            //     ),
                                            //     isDismissible: true,
                                            //     dismissDirection:
                                            //         FlushbarDismissDirection
                                            //             .HORIZONTAL,
                                            //     duration: Duration(seconds: 3),
                                            //     margin: EdgeInsets.all(8),
                                            //     borderRadius: 8,
                                            //   )..show(context);
                                            //   await Future.delayed(
                                            //       Duration(seconds: 2));

                                            //   Navigator.push(
                                            //       context,
                                            //       PageTransition(
                                            //           type: PageTransitionType
                                            //               .fade,
                                            //           duration: Duration(
                                            //               milliseconds: 200),
                                            //           child: Homie()));
                                            //   quickreloader = 1;
                                            //   await setquickreload();
                                            // }
                                          }
                                        }
                                      }
                                    },
                                    onTapDown: (_) {
                                      print('Secondary');
                                      if (wicked == 0) {
                                        if (switchmuch == 1) {
                                          setState(() {
                                            switchimation = 'Off';
                                            // bgservice = 0;
                                            isiton = 0;
                                            crywolf = 0;
                                            panik = 1;
                                          });
                                          _boNotification();

                                          print("Turned off");
                                          switchmuch -= 1;
                                        }
                                      }
                                    },
                                    onTap: () {
                                      if (wicked == 0) {
                                        if (switchmuch == 0) {
                                          {
                                            print("333");
                                            print("donemachi");
                                            wicked = 1;
                                          }
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: deviceWidth / 6,
                                      height: deviceWidth / 10,
                                      child: FlareActor('lib/Start/kg.flr',
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                          animation: switchimation),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

//PLAY MF!

                          Center(
                            child: DescribedFeatureOverlay(
                              featureId:
                                  'add_item_feature_play', // Unique id that identifies this overlay.
                              tapTarget: IconButton(
                                icon: Icon(Icons.play_arrow_outlined),
                                color: Colors.white,
                                iconSize: 50,
                                onPressed: () async {
                                  FeatureDiscovery.completeCurrentStep(context);
                                  pretend();
                                },
                              ), // The widget that will be displayed as the tap target.
                              title: Text('See what Phoenix can do'),
                              description: Text('Try your preloaded Phoenix.'),
                              backgroundColor: const Color(0xFF160d2a),
                              targetColor: Colors.transparent,
                              textColor: Colors.white,

                              child: GestureDetector(
                                onTap: () async {
                                  var winger = await getwidget();
                                  if (winger != "NONE") {
                                    if (unloading == 2) {
                                      Flushbar(
                                        backgroundColor: Colors.black87,
                                        message: "LOADING...(beep-boop)",
                                        icon: Icon(
                                          Icons.timelapse,
                                          size: 28.0,
                                          color: Colors.cyanAccent[700],
                                        ),
                                        isDismissible: true,
                                        dismissDirection:
                                            FlushbarDismissDirection.HORIZONTAL,
                                        duration: Duration(seconds: 5),
                                        margin: EdgeInsets.all(8),
                                        borderRadius: 8,
                                      )..show(context);
                                    } else if (play == 0 && unloading != 2) {
                                      setState(() {
                                        currentanimation = pltpa;
                                        print(currentanimation);
                                        play += 1;
                                        // print("OVER OVER I REPEAT OVER");
                                      });
                                      // print("wait");
                                      if (somewhe == 0) {
                                        await buttonfunction();
                                      } else if (somewhe == 1) {
                                        if (colorhandler == 0) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 100),
                                              child: Screenfook(),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 100),
                                              child: Purplefook(),
                                            ),
                                          );
                                        }
                                      }

                                      // setState(() {
                                      //   currentanimation = patpl;
                                      // });
                                    } else if (play == 1 && unloading != 2) {
                                      await audioPlayer.stop();
                                      setState(() {
                                        stormed = 0;
                                        currentanimation = patpl;
                                        print(currentanimation);

                                        bratva = 1;
                                        play -= 1;
                                        // print("Restarted stats");
                                      });
                                    }
                                  } else if (winger == "NONE") {
                                    Flushbar(
                                      backgroundColor: Colors.black87,
                                      message: "Select a song!",
                                      icon: Icon(
                                        Icons.music_note_rounded,
                                        size: 28.0,
                                        color: const Color(0xFFCB0047),
                                      ),
                                      isDismissible: true,
                                      dismissDirection:
                                          FlushbarDismissDirection.HORIZONTAL,
                                      duration: Duration(seconds: 5),
                                      margin: EdgeInsets.all(8),
                                      borderRadius: 8,
                                    )..show(context);
                                  }
                                },
                                child: Container(
                                  width: deviceWidth / 7,
                                  height: deviceWidth / 7,
                                  // child: IconButton(
                                  //     icon: Icon(Icons.album),
                                  //     iconSize: 45,
                                  //     color: const Color(0xFFCB0047),
                                  //     onPressed: () async {
                                  //       await buttonfunction();
                                  //     }),
                                  child: FlareActor('lib/Start/sizing.flr',
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                      color: Colors.white,
                                      animation: currentanimation),
                                ),
                              ),
                            ),
                          ),

                          // Center(
                          //   child: IconButton(
                          //     icon: Icon(Icons.stop),
                          //     iconSize: 45,
                          //     color: const Color(0xFFCB0047),
                          //     onPressed: () async {
                          //       FlutterRingtonePlayer.playRingtone();
                          //       await Future.delayed(Duration(seconds: 5));
                          //       FlutterRingtonePlayer.stop();
                          //     },
                          //   ),
                          // ),

                          //MUSIC WIDGET

                          Center(
                            child: Text(
                              '<         $afgodzilla         >',
                              style: TextStyle(
                                  fontFamily: "Fontz",
                                  fontWeight: FontWeight.w300,
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
            ),
          ],
        ),
      ),
    );
  }

  static const platform = const MethodChannel("com.Phoenix.project/kotlin");
  void Setty() async {
    var kotlincall;
    var kotlinoowee = owee;
    var sendmap = <String, dynamic>{"val1": '$extofsong'};
    try {
      kotlincall = await platform.invokeMethod("Setty", sendmap);
    } catch (e) {
      print(e);
      print('jokes on you');
    }
    print(kotlincall);
  }

  void PermPerm() async {
    var permi;
    try {
      permi = await platform.invokeMethod("Gandhi");
    } catch (e) {
      print(e);
      print('jokes on you');
    }
    print(permi);
  }

  pretend() async {
    setState(() {
      currentanimation = pltpa;
      print(currentanimation);
      play += 1;
    });
    await buttonfunction();
  }

  Future notificationSelected(String payload) {}

  void brakesforlife() async {
    await audioPlayer.stop();
    bratva = 1;
    play -= 1;
    print("Restarted stats");
    stormed = 0;
  }

  void upload(File file) async {
    unloading = 2;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Flushbar(
        backgroundColor: Colors.black87,
        message: "Pro Tip: Use a Faster Internet for a faster completion.",
        icon: Icon(
          Icons.speed,
          size: 28.0,
          color: Colors.redAccent[400],
        ),
        isDismissible: true,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        duration: Duration(seconds: 5),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      )..show(context);
    }
    print("jumptest");

    print("jumped");
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    //    final File outter = File('${dirToSave}output.pdf');
    Dio dio = Dio();
    try {
      errorwidgetcheck = 0;
      //    var dirToSave = await getApplicationDocumentsDirectory();
      await dio.post("http://639.619.6289.61479", data: data);
      dickhead();
    } catch (e) {
      print("HITMEWITHARIPTIDE!");
      await showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(child: Text('')),
              FlareLoading(
                height: DEVICEWIDTH / 1.5,
                width: DEVICEWIDTH / 1.5,
                startAnimation: 'error-message',
                loopAnimation: 'error-message',
                name: 'lib/Start/no_netbruh.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                onError: (_, stacktrace) {},
                onSuccess: (_) {},
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "What Went Wrong?",
                      style: TextStyle(
                          inherit: false,
                          fontSize: DEVICEHEIGHT / 50,
                          fontFamily: 'InterR',
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      "The server is under Maintainance, \nTry after some time. \nReport me if persistent.",
                      style: TextStyle(
                          inherit: false,
                          fontSize: DEVICEHEIGHT / 50,
                          fontFamily: 'InterL',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      errorwidgetcheck = 1;
      _btnController.error();
      print(errorwidget);
      // setState(() {
      //   afgodzilla = errorwidget;
      // });
    }
  }

  void dickhead() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    //Directory appDocDir = await getApplicationDocumentsDirectory();
    //String appDocPath = appDocDir.path;
    String localPath = appDocPath + Platform.pathSeparator + 'darted_csv';
    //String localPath = "assets/res/darted.csv";
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    //  final temp = await getApplicationDocumentsDirectory();
    //print(temp);
    print(localPath);

    await FlutterDownloader.enqueue(
      url: "http://3.19.28.147/sagan",
      savedDir: localPath,

      showNotification:
          false, // show download progress in status bar (for Android)
      openFileFromNotification:
          false, // click on notification to open downloaded file (for Android)
    );
    unloading = 0;
    _btnController.success();
    await Future.delayed(Duration(seconds: 5));
    _btnController.reset();
  }

  void initializer() async {
    WidgetsFlutterBinding.ensureInitialized();
    brakes = 1;
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  void hobahabilis() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String localPath =
        appDocPath + Platform.pathSeparator + 'darted_csv/darted.csv';
  }

  setwidget() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('widgetstring', howmany);
    // print("you just got slaaaped with {$howmany}");
  }

  crumbling() async {
    print("you got me hypnotised");
    audioPlayer.onPlayerCompletion.listen((event) async {
      await audioPlayer.stop();
      brakesforlife();
      print("Restarted stats");
      setState(() {
        currentanimation = patpl;
      });
    });
  }

  M3rcurial() async {
    var annika = await getExternalStorageDirectory();
    var wells = annika.path;
    print(wells);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    final String alocalPath = appDocDir.path;
    File shwey = File('$alocalPath/Avengers-infinity-remix-RzM.mp3');
    extofsong = "mp3";
    final newFile = await shwey.copy("$wells/phoenixringtone.$extofsong");
    await setringtoneext();

    return newFile;
  }

  vettimundo() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    String localPath = appDocPath + Platform.pathSeparator + 'darted_csv';

    final savedDir = Directory(localPath);

    savedDir.create();
  }

  setquickreload() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('hotreload', quickreloader);
  }

  dleta() async {
    var annika = await getExternalStorageDirectory();
    var wells = annika.path;
    print(wells);
    var deletion;
    print("below");
    if (FileSystemEntity.typeSync("$wells/phoenixringtone.mp3") !=
        FileSystemEntityType.notFound) {
      new Directory("$wells/phoenixringtone.mp3").delete(recursive: true);
      print("caughtit");
    } else if (FileSystemEntity.typeSync("$wells/phoenixringtone.wav") !=
        FileSystemEntityType.notFound) {
      new Directory("$wells/phoenixringtone.wav").delete(recursive: true);
      print("caughtit");
    } else if (FileSystemEntity.typeSync("$wells/phoenixringtone.m4a") !=
        FileSystemEntityType.notFound) {
      new Directory("$wells/phoenixringtone.m4a").delete(recursive: true);
      print("caughtit");
    } else if (FileSystemEntity.typeSync("$wells/phoenixringtone.aac") !=
        FileSystemEntityType.notFound) {
      new Directory("$wells/phoenixringtone.aac").delete(recursive: true);
      print("caughtit");
    } else if (FileSystemEntity.typeSync("$wells/phoenixringtone.flac") !=
        FileSystemEntityType.notFound) {
      new Directory("$wells/phoenixringtone.flac").delete(recursive: true);
      print("caughtit");
    } else {
      print("none found --skipping");
    }
  }

  bowler() async {
    try {
      var annika = await getExternalStorageDirectory();
      var wells = annika.path;
      print(wells);
      var deletion;
      var thisishowidienow = await getaudiowidget();
      thisishowidienow = thisishowidienow.toString();
      thisishowidienow = thisishowidienow.replaceRange(0, 6, '');
      print(thisishowidienow);
      thisishowidienow = thisishowidienow.replaceRange(0, 1, '');
      print(thisishowidienow);

      print(thisishowidienow);
      thisishowidienow =
          thisishowidienow.substring(0, thisishowidienow.length - 1);
      print(thisishowidienow);
      File ohicarus = File(thisishowidienow);
      print("below");
      // await new Directory(deletion).delete(recursive: true);
      final newFile = await ohicarus.copy("$wells/phoenixringtone.$extofsong");
      await startend();
      return newFile;
    } catch (e) {
      print(e);
    }
  }

  startend() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String localPath =
          appDocPath + Platform.pathSeparator + 'darted_csv/darted.csv';
      File vadai = File("$localPath");

      final bloom = await vadai.copy("$appDocPath/darted_csv/isohel.csv");
      return bloom;
    } catch (e) {
      print("its isohel");
      print(e);
    }
  }

  setaudio() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('audiostring', owee);
    // print("you just got slaaaped with {$owee}");
  }

  setsensitivity() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble('setsensitivity', anothersensitivity);
    // print("you just got slaaaped with {$anothersensitivity}");
    // print(anothersensitivity);
  }

  setdrugs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('druggedup', drug);
  }

  setdummy() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('dummie', 1);
  }

  setringtoneext() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ringext', extofsong);
  }

/////////////////////////////////NOTION/////////////////////////////////////////

  _watchAllPhoneCallEvents() async {
    if (crywolf == 1) {
      FlutterPhoneState.rawPhoneEvents.forEach((RawPhoneEvent event) async {
        final phoneCall = event.type;
        print(phoneCall);
        if (phoneCall == RawEventType.inbound) {
          if (panik == 0) {
            passer = 0;
            await bestfunctionintheworld();
            print("shaan");
          }
        }
        if (phoneCall == RawEventType.connected) {
          setState(() {
            passer = 1;
          });
        }
        if (phoneCall == RawEventType.disconnected) {
          setState(() {
            passer = 1;
          });
        }

        print("Got an event $event");
      });
      print("That loop ^^ won't end");
    } else {
      return;
    }
  }

///////////////////////////////   button     ///////////////////////////////////

  buttonfunction() async {
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
      print(replacethat);
      replacethat = replacethat.replaceRange(0, 1, '');
      print(replacethat);

      print(replacethat);
      replacethat = replacethat.substring(0, replacethat.length - 1);
      print(replacethat);
    } else {
      replacethat = audiofilestored.toString();
    }
    var anothervariable = 0;

    await audioPlayer.play(replacethat);
    // var notionduration = audioPlayer.onPlayerStateChanged.listen((event) {
    //   print("changed");

    //   if (anothervariable == 0) {
    //     if (stoppingaudio == 0) {
    //       anothervariable = 1;
    //       stoppingaudio += 1;
    //     }
    //   } else if (anothervariable == 1) {
    //     if (stoppingaudio == 1) {
    //       brakesforlife();
    //       stoppingaudio -= 1;
    //     }
    //   }
    // });
    // print(notionduration);
    stormed = 1;
    await ahboinkboink();

    var shaan;
    var dumbo;
    var listed;
    var line;
    var beeu;
    var drtime;
    final duration = const Duration(microseconds: 333333);
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
    if (listed.length == 600) {
      sleeping = 100;
    }

    outerloop:
    for (var i = 0; i < listed.length; i = i + 1) {
      line = listed[i];
      dork = double.parse(line);

      if (bratva == 1) {
        break outerloop;
      }

      _stopWatchTimer.onExecute.add(StopWatchExecute.start);

      if (dork <= globalshot) {
        await TorchCompat.turnOn();

        if (globalhayabusa == 1) {
          await Vibration.vibrate(duration: 290);
        }
        // await Future.delayed(const Duration(microseconds: 333333));
      } else {
        await TorchCompat.turnOff();
        // await Future.delayed(const Duration(microseconds: 333333));
      }

      // print(beeu);
      if (displayTime == null) {
        beeu = 0;
      } else {
        beeu = int.parse(displayTime.toString().replaceAll("00:00:00.", ""));
      }
      drtime = 290 - (beeu * 10);
      // print("$drtime" + "-----$i -$dork");
      await Future.delayed(Duration(milliseconds: drtime));
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    }
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    print("over");
    await TorchCompat.turnOff();
    await audioPlayer.stop();
    setState(() {
      currentanimation = patpl;
    });
    bratva = 0;
    play = 0;
  }

////////////////////////////// Screen Fuck /////////////////////////////////////

  screenfunction() async {
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
      print(replacethat);
      replacethat = replacethat.replaceRange(0, 1, '');
      print(replacethat);

      print(replacethat);
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
    var beeu;
    var drtime;
    final duration = const Duration(microseconds: 333333);
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
    if (listed.length == 600) {
      sleeping = 100;
    }
    // await showDialog(
    //     context: context,
    //     builder: (BuildContext context) => Container(
    //           color: dynamocolor,
    //         ));

    outerloop:
    for (var i = 0; i < listed.length; i = i + 1) {
      line = listed[i];
      print(i);
      dork = double.parse(line);

      if (bratva == 1) {
        break outerloop;
      }

      if (dork <= globalshot) {
        setState(() {
          dynamocolor = Colors.white;
        });

        if (globalhayabusa == 1) {
          await Vibration.vibrate(duration: 300);
        }
        await Future.delayed(const Duration(microseconds: 300000));
      } else {
        setState(() {
          dynamocolor = Colors.blueGrey;
        });
        await Future.delayed(const Duration(microseconds: 300000));
      }
    }

    print("over");
    await audioPlayer.stop();
    setState(() {
      currentanimation = patpl;
    });
    bratva = 0;
    play = 0;
  }

//////////////////////////////    call     /////////////////////////////////////

  bestfunctionintheworld() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String localPath =
        appDocPath + Platform.pathSeparator + 'darted_csv/darted.csv';
    print("YOU SEEING THIS SHIT!");
    final String alocalPath = appDocDir.path;

    // var shaan = await File(localPath).readAsString();

    // LineSplitter.split(shaan).forEach((line) async {
    //   double dork = double.parse(line);
    // var dumbo = LineSplitter.split(shaan);
    // var listed = dumbo.toList();
    var dumbo;
    var shaan;
    var listed;
    var beeu;
    var drtime;
    if (audiofilestored != '$alocalPath/Avengers-infinity-remix-RzM.mp3') {
      shaan = await File("$appDocPath/darted_csv/isohel.csv").readAsString();
      dumbo = LineSplitter.split(shaan);
      listed = dumbo.toList();
      print("custom");
    } else {
      shaan = await rootBundle.loadString("lib/Start/avengers.csv");
      dumbo = LineSplitter.split(shaan);
      listed = dumbo.toList();
      print("stock");
    }

    disconnectloop:
    for (var i = 0; i < listed.length; i = i + 1) {
      var line = listed[i];
      double dork = double.parse(line);
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      if (passer == 1) {
        break disconnectloop;
      }

      if (dork <= globalshot) {
        await TorchCompat.turnOn();

        if (globalhayabusa == 1) {
          await Vibration.vibrate(duration: 290);
        }
      } else {
        await TorchCompat.turnOff();
      }
      // print(beeu);
      if (displayTime == null) {
        beeu = 0;
      } else {
        beeu = int.parse(displayTime.toString().replaceAll("00:00:00.", ""));
      }
      drtime = 290 - (beeu * 10);
      // print("$drtime" + "-----$i -$dork");
      await Future.delayed(Duration(milliseconds: drtime));
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    }
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    print("over");
    TorchCompat.turnOff();
  }
}

ahboinkboink() async {
  if (stormed != 2) {
    audioPlayer.onPlayerCompletion.listen((event) async {
      await audioPlayer.stop();
      bratva = 1;
      play -= 1;
      print("Restarted stats");
    });
  }
}
