import 'dart:io';
// import 'dart:typed_data';
import 'package:audiotagger/audiotagger.dart';
import 'package:phoenix/src/Begin/begin.dart';
// import 'package:phoenix/src/Begin/native_call/goNative.dart';

ringtoneTrimAlgo(data) async {
  final tagger = new Audiotagger();
      Map<String, String> tags = {
      "title": null,
      "artist": null,
      "genre": null,
      "trackNumber": null,
      "trackTotal": null,
      "discNumber": null,
      "discTotal": null,
      "lyrics": null,
      "comment": null,
      "album": null,
      "albumArtist": null,
      "year": null,
      "artwork": "", // Null if obtained from readTags or readTagsAsMap
    };
  await File(data.data).copy("${applicationFileDirectory.path}/phoenix.flac");
  tagger.writeTagsFromMap( 
      path: "${applicationFileDirectory.path}/phoenix.flac", tags: tags);
  print(data.size);
  // double bytesPerSecond = data.size / (getDuration(data) / 1000);
  // print(bytesPerSecond);
  // Uint8List bytesInuin = await File(data.data).readAsBytes();
  // var bytes = bytesInuin.toList();
  // // bytes.buffer.asUint8List();
  // print(bytes);
  // print(bytes.length);
  // bytes.removeRange(0, bytes.length ~/ 2);

  // if (File("/storage/emulated/0/Download/phoenixNeue.flac").existsSync()) {
  //   File("/storage/emulated/0/Download/phoenixNeue.flac").delete();
  // }
  // final pathOfAudio =
  //     await File('/storage/emulated/0/Download/phoenixNeue.flac').create();
  // await pathOfAudio.writeAsBytes(Uint8List.fromList(bytes));
  // await broadcastFileChange('/storage/emulated/0/Download/phoenixNeue.flac');
}
