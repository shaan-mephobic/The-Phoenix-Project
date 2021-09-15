import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/begin.dart';
import 'native/go_native.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

Future<void> ringtoneTrim(
    {@required pathOfFile,
    @required List ranges,
    @required String title,
    @required String artist}) async {
  final String ext = getFileExt(pathOfFile);
  final String inputFile = "${applicationFileDirectory.path}/raw$ext";
  final String outputFile = "${applicationFileDirectory.path}/ringtone$ext";
  final String start = Duration(milliseconds: ranges[0] ~/ 1).toString();
  final String length = (Duration(milliseconds: ranges[1] ~/ 1) -
          Duration(milliseconds: ranges[0] ~/ 1))
      .toString();
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

  await File(pathOfFile).copy("${applicationFileDirectory.path}/raw$ext");
  await _flutterFFmpeg
      .execute("-ss $start -i $inputFile -t $length -c copy $outputFile")
      .then((rc) => print("FFmpeg process exited with rc $rc"));
  await File(inputFile).delete();
    setRingtone(outputFile, title, artist);

}

String getFileExt(String file) {
  String trim = file.replaceRange(0, file.length - 5, "");
  if (trim.contains(".")) {
    String ext = trim.replaceRange(0, trim.indexOf("."), "");
    return ext;
  } else {
    throw "No Extension found in $file";
  }
}
