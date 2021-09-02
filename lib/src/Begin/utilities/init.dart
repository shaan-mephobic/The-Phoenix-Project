import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import '../begin.dart';
import 'package:device_info/device_info.dart';

cacheImages() async {
  ByteData bytes = await rootBundle.load('assets/res/background.jpg');
  art = bytes.buffer.asUint8List();
  defaultArt = art;
  ByteData bites = await rootBundle.load('assets/res/default.jpg');
  defaultNone = bites.buffer.asUint8List();
}

dataInit() async {
  await Hive.initFlutter();
  musicBox = await Hive.openBox('musicDataBox');
  var info = await DeviceInfoPlugin().androidInfo;
  isAndroid11 = info.version.sdkInt > 29 ? true : false;
}

fetchSongs() async {
  if (await Permission.storage.request().isGranted) {
    var what = OnAudioQuery().querySongs(
        sortType: SongSortType.DEFAULT,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL);
    songList = await what;
    if (musicBox.get('customScan') ?? false) {
      List<SongModel> updateList = [];
      specificAlbums = [];
      for (int i = 0; i < songList.length; i++) {
        foundAlready:
        if (musicBox.get('customLocations') != null) {
          for (int o = 0; o < musicBox.get('customLocations').length; o++) {
            if (songList[i]
                .data
                .contains(musicBox.get('customLocations')[o].toString())) {
              updateList.add(songList[i]);
              specificAlbums.add(songList[i].album.toUpperCase());
              break foundAlready;
            }
          }
        }
      }
      specificAlbums.toSet().toList();
      songList = updateList;
    }
    if (musicBox.get('clutterFree') ?? false) {
      for (int i = 0; i < songList.length; i++) {
        if (getDuration(songList[i]) < 30000) {
          songList.remove(songList[i]);
          i -= 1;
        }
      }
    }
    permissionGiven = true;
  } else {
    permissionGiven = false;
  }
}
