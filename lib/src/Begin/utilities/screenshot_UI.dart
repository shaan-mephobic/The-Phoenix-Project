import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:phoenix/src/Begin/begin.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phoenix/src/Begin/utilities/native/go_native.dart';
import 'package:screenshot/screenshot.dart';
import 'filters.dart';

screenShotUI(save) async {
  // await Future.delayed(Duration(seconds: 1));
  // print("forever//");
  // remove the old file cuz gettin error
  ScreenshotController screenshotController = ScreenshotController();

  await screenshotController
      .captureFromWidget(
    // Stack(
    //   children: [
    Container(
      height: deviceHeight / 1.3,
      width: deviceWidth / 1.3,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: MemoryImage(first ? art : art2),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Stack(
        children: [
          // QueryArtworkWidget(
          //   id: nowMediaItem.extras['id'],
          //   type: ArtworkType.AUDIO,
          //   artwork: "",
          //   deviceSDK: deviceInfo.sdk,
          //   format: ArtworkFormat.JPEG,
          //   size: 600,
          //   artworkQuality: FilterQuality.high,
          //   keepOldArtwork: true,
          // ),
          Container(
            height: deviceHeight / 1.3,
            width: deviceWidth / 1.3,
            child: Image.memory(
              first ? art ?? defaultNone : art2 ?? defaultNone,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: deviceHeight / 1.3,
            width: deviceWidth / 1.3,
            child: ClipRRect(
              // make sure we apply clip it properly
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.2),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: deviceWidth / 12, right: deviceWidth / 12),
                    child: Center(
                        child: Text(
                      aetheticText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          inherit: false,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                          fontSize: deviceWidth / 12),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  )
      .then(
    (capturedImage) async {
      if (!save) {
        Directory appDocDir = await getExternalStorageDirectory();
        String appDocPath = appDocDir.path;
        if (File("$appDocPath/legendary-er.png").existsSync()) {
          File("$appDocPath/legendary-er.png").delete();
        }
        final pathOfImage = await File('$appDocPath/legendary-er.png').create();
        final Uint8List bytes = capturedImage.buffer.asUint8List();
        await pathOfImage.writeAsBytes(bytes);
        // print("over");
      } else {
        final pathOfImage =
            await File('/storage/emulated/0/Download/${aetheticText()}.png')
                .create();
        final Uint8List bytes = capturedImage.buffer.asUint8List();
        await pathOfImage.writeAsBytes(bytes);
        await broadcastFileChange(
            '/storage/emulated/0/Download/${aetheticText()}.png');
      }
    },
  );
}

class WallpaperArt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(first ? art : art2),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        // make sure we apply clip it properly
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.2),
            child: Center(
                child: Text(
              aetheticText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  inherit: false,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                  fontSize: deviceWidth / 10),
            )),
          ),
        ),
      ),
    );
  }
}
