
// import 'dart:isolate';

// import 'package:flutter/material.dart';
// import 'package:palette_generator/palette_generator.dart';
// import 'package:phoenix/src/Begin/pages/albums/albums_back.dart';

// class IsolatedArtistScrape {
//   final receivePort = ReceivePort();
//   Isolate _isolate;

//   void stop() {
//     if (_isolate != null) {
//       receivePort.close();
//       print("way down we go");
//       _isolate.kill(priority: Isolate.immediate);
//       _isolate = null;
//     }
//   }

//   Future<void> start() async {
//     Map map = {
//       "artworks": albumsArts,
//       "allAlbums": allAlbumsName,
//     };

//     _isolate = await Isolate.spawn(_entryPoint, map);
//     receivePort.listen(_handleMessage, onDone: () {
//       print("HEYA!");
//     });
//     // receivePort.sendPort.send(initialDuration);
//   }

//   void _handleMessage(dynamic data) async {
//     // NON ISOLATE PART
//     // print(data);
//     // if (data[1] != null && data[1].startsWith("https")) {
//     //   var response = await http.get(Uri.parse(data[1]));
//     //   File file =
//     //       File("${applicationFileDirectory.path}/artists/${data[0]}.jpg");

//     // }
//     // Map mapOfArtists = musicBox.get("mapOfArtists") ?? {};
//     // mapOfArtists["${data[0]}"] = data[1];
//     // musicBox.put("mapOfArtists", mapOfArtists);
//   }

//   static void _entryPoint(Map map) async {
//     print("COLORS");
//     Color nowColor;
//     Color nowContrast;

//     colorPallete(ImageProvider image) async {
//       print(image);
//       Color dominantAlbum;
//       Color contrastAlbum;
//       PaletteGenerator paletteGenerator;
//       print("shaanaahssshaif");
//       paletteGenerator = await PaletteGenerator.fromImageProvider(image);
//       print("start//end");
//       dominantAlbum = (paletteGenerator.dominantColor.color);
//       // print(dominant_album);
//       if (dominantAlbum.computeLuminance() <= 0.5) {
//         try {
//           var pal = paletteGenerator.lightMutedColor.color;
//           contrastAlbum = pal;
//         } catch (e) {
//           contrastAlbum = Colors.white;
//         }

//         if (dominantAlbum == contrastAlbum) {
//           // print("damn! thats rare");
//           contrastAlbum = paletteGenerator.darkMutedColor.color;
//         }
//       } else {
//         try {
//           var pal = (paletteGenerator.darkMutedColor.color);
//           contrastAlbum = pal;
//         } catch (e) {
//           contrastAlbum = Colors.black;
//         }
//         if (dominantAlbum == contrastAlbum) {
//           // print("damn! thats rare");
//           contrastAlbum = paletteGenerator.lightMutedColor.color;
//         }
//       }
//       if ((dominantAlbum.computeLuminance() - contrastAlbum.computeLuminance())
//               .abs() <
//           0.2) {
//         if (dominantAlbum.computeLuminance() < 0.5) {
//           contrastAlbum = Colors.white;
//         } else {
//           contrastAlbum = Colors.black;
//         }
//       }

//       // print(contrast_album);

//       return [dominantAlbum.value, contrastAlbum.value];
//       // Map colorDB = musicBox.get("colorsDB") ?? {};
//       // colorDB[nowMediaItem.id] = [nowColor.value, nowContrast.value];
//       // musicBox.put("colorsDB", colorDB);
//     }
//     albumArtsColors(){
//       for(int i=0;i<map["allAlbums"].length;i++){
        
//       }
//     }

//     IsolatedArtistScrape().stop();
//   }
// }
