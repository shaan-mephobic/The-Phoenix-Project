// // import 'dart:async';
// // import 'dart:io';
// import 'dart:isolate';
// import 'dart:typed_data';
// // import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:on_audio_query/on_audio_query.dart';
// // import 'package:palette_generator/palette_generator.dart';
// // import 'package:phoenix/src/beginning/begin.dart';
// import 'package:flutter_isolate/flutter_isolate.dart';

// // class IsolatedColorPalette {
// //   final receivePort = ReceivePort();
// //   Isolate _isolate;

// // void stop() {
// //   if (_isolate != null) {
// //     receivePort.close();
// //     print("way down we go");
// //     _isolate.kill(priority: Isolate.immediate);
// //     _isolate = null;
// //   }
// // }

// // Future<void> start() async {
// //   Map map = {"songList": songList};
// //   _isolate = await Isolate.spawn(_entryPoint, map);
// //   receivePort.listen(_handleMessage, onDone: () {
// //     print("HEYA!");
// //   });
// //   // receivePort.sendPort.send(initialDuration);
// // }

// // void _handleMessage(dynamic data) async {
// //   // NON ISOLATE PART
// // }

// isolatedColorPalette(SendPort port) async {
//   // Map<String, List<int>> allData = {};
//   print("beginning");
//   port.send("Hello!");
//   port.send("fuck1");
//   ByteData bytes = await rootBundle.load('assets/res/background1.jpg');
//   port.send("fuck2");
//   var art = bytes.buffer.asUint8List();
//   port.send("fuck3");
//   port.send(art);
//   // port.send(await colorPalette(MemoryImage(art)));
//   // Future<List<int>> colorPalette(ImageProvider imageProvider) async {
//   //   Color dominant;
//   //   Color contrast;
//   //   final PaletteGenerator paletteGenerator =
//   //       await PaletteGenerator.fromImageProvider(imageProvider);
//   //   dominant = (paletteGenerator.dominantColor.color);
//   //   if (dominant.computeLuminance() <= 0.5) {
//   //     try {
//   //       var pal = paletteGenerator.lightMutedColor.color;
//   //       contrast = pal;
//   //     } catch (e) {
//   //       contrast = Colors.white;
//   //     }
//   //     if (dominant == contrast) {
//   //       contrast = paletteGenerator.darkMutedColor.color;
//   //     }
//   //   } else {
//   //     try {
//   //       var pal = (paletteGenerator.darkMutedColor.color);
//   //       contrast = pal;
//   //     } catch (e) {
//   //       contrast = Colors.black;
//   //     }

//   //     if (dominant == contrast) {
//   //       contrast = paletteGenerator.lightMutedColor.color;
//   //     }
//   //   }
//   //   if ((dominant.computeLuminance() - contrast.computeLuminance()).abs() <
//   //       0.2) {
//   //     if (dominant.computeLuminance() < 0.5) {
//   //       contrast = Colors.white;
//   //     } else {
//   //       contrast = Colors.black;
//   //     }
//   //   }
//   //   return [dominant.value, contrast.value];
//   // }

//   // for (int i = 0; i < songList.length; i++) {
//   //   Uint8List artwork =
//   //       await OnAudioQuery().queryArtwork(songList[i].id, ArtworkType.AUDIO);
//   //   print(songList[i].title);
//   //   if (artwork != null) {
//   //     List<int> color = await colorPalette(MemoryImage(artwork));
//   //     allData[songList[i].data] = color;
//   //   }
//   // }
//   // musicBox.put("colorsDB", allData);

//   // print(map["songList"][0].title);
//   // var sendPort = map['port'];

//   // await Future.delayed(Duration(seconds: 2));
//   print("going down bro!");

//   // for (int i = 0; i < map['songList'].length; i++) {
//   //   Uint8List artwork = await OnAudioQuery().queryArtwork(
//   //     map['songList'][i].id,
//   //     ArtworkType.AUDIO,
//   //   );
//   //   if (artwork != null) {
//   //     print(map['songList'][i].title);
//   //     print(await colorPalette(MemoryImage(artwork)));
//   //   }
//   // }
// }

// isolatedColorInit() async {
//   var port = ReceivePort();
//   port.listen((msg) {
//     print("Received message from isolate $msg");
//   });
//   var _isolate =
//       await FlutterIsolate.spawn(isolatedColorPalette, port.sendPort);
//   _isolate.kill();
// }
