import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/genres_back.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/mansion_back.dart';
import 'package:phoenix/src/Begin/utilities/scraping/image_scrape.dart';
import '../begin.dart';
import 'package:device_info/device_info.dart';

import 'has_network.dart';

cacheImages() async {
  applicationFileDirectory = await getApplicationDocumentsDirectory();
  ByteData bytes = await rootBundle.load('assets/res/background1.jpg');
  art = bytes.buffer.asUint8List();
  defaultArt = art;
  if (!await File("${applicationFileDirectory.path}/artworks/null.jpeg")
      .exists()) {
    ByteData bites = await rootBundle.load('assets/res/default.jpg');
    defaultNone = bites.buffer.asUint8List();
  } else {
    defaultNone =
        await File("${applicationFileDirectory.path}/artworks/null.jpeg")
            .readAsBytes();
  }
}

dataInit() async {
  await Hive.initFlutter();
  musicBox = await Hive.openBox('musicDataBox');
  var info = await DeviceInfoPlugin().androidInfo;
  isAndroid11 = info.version.sdkInt > 29 ? true : false;
  glassBlur = ImageFilter.blur(
      sigmaX:
          musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
      sigmaY:
          musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"));
  glassOpacity = Colors.white.withOpacity(
      (musicBox.get("glassOverlayColor") == null
              ? 3
              : musicBox.get("glassOverlayColor")) /
          100);
  glassShadowOpacity =
      musicBox.get("glassShadow") == null ? 10 : musicBox.get("glassShadow");
}

fetchSongs() async {
  if (await Permission.storage.request().isGranted) {
    var what = OnAudioQuery().querySongs(
        sortType: SongSortType.TITLE,
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

fetchAll() async {
  if (ascend) {
    await fetchSongs();
  }
  await gettinAlbums();
  await songListToMediaItem();
  await gettinArtists();
  await gettinMansion();
  await gettinAlbumsArts();
  await gettinArtistsAlbums();
  await gettinGenres();
  await smartArtistsArts();
  ascend = true;
  print("ASCENDED");
  rootState.provideman();
  if (musicBox.get("isolation") == null
      ? true
      : !musicBox.get("isolation") && await hasNetwork()) {
    /// TODO do scraping only when phone's awake so you don't get HandshakeException: Connection terminated during handshake
    isolatedArtistScrapeInit();
  }
}

songListToMediaItem() async {
  songListMediaItems = [];
  for (int i = 0; i < songList.length; i++) {
    MediaItem item = MediaItem(
        id: songList[i].data,
        album: songList[i].album,
        artist: songList[i].artist,
        duration: Duration(milliseconds: getDuration(songList[i])),
        artUri: Uri.file(allAlbumsName.contains(songList[i].album)
            ? musicBox.get("AlbumsWithoutArt") == null
                ? "${applicationFileDirectory.path}/artworks/${songList[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
                : musicBox.get("AlbumsWithoutArt").contains(songList[i].album)
                    ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                    : "${applicationFileDirectory.path}/artworks/${songList[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
            : "${applicationFileDirectory.path}/artworks/null.jpeg"),
        title: songList[i].title,
        extras: {"id": songList[i].id});
    songListMediaItems.add(item);
  }
}
