import 'dart:collection';
import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import '../../pages/mansion/mansion.dart';

List mansionArtists = [];
List mansionAlbums = [];
List<SongModel> recentPlayed = [];
List<MediaItem> recentPlayedMediaItems = [];
List<SongModel> everPlayedLimited = [];
List<MediaItem> everPlayedLimitedMediaItems = [];
List<SongModel> alwaysPlayed = [];
List<MediaItem> alwaysPlayedMediaItems = [];
int recentPlayedLength = 0;

gettinMansion() async {
  Map? leMansion = musicBox.get('crossfire');
  if (leMansion != null) {
    mansionArtists = [];
    mansionAlbums = [];
    recentPlayed = [];
    everPlayedLimited = [];
    alwaysPlayed = [];
    recentPlayedMediaItems = [];
    everPlayedLimitedMediaItems = [];
    alwaysPlayedMediaItems = [];
    sortAlgo(leMansion);
  }
}

// One arrangement to see all the fav artists,albums,songs(recent).

sortAlgo(Map raw) {
  Map simplify = {};
  var keys = raw.keys.toList();
  Map simplify2 = {};

// Recently played algo

  for (int i = 0; i < raw.length; i++) {
    simplify[keys[i]] = raw.values.toList()[i][3];
  }

  List sortedKeys = simplify.keys.toList(growable: false)
    ..sort((k1, k2) => simplify[k1].compareTo(simplify[k2]));
  LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => simplify[k]);
  for (int i = 0; i < sortedMap.length; i++) {
    sortedMap[keys[i]] = raw[keys[i]];
  }

// Top Played algo

  for (int i = 0; i < raw.length; i++) {
    simplify2[keys[i]] = raw.values.toList()[i][0];
  }
  List sortedKeys2 = simplify2.keys.toList(growable: false)
    ..sort((k1, k2) => simplify2[k1].compareTo(simplify2[k2]));
  LinkedHashMap sortedMap2 = LinkedHashMap.fromIterable(sortedKeys2,
      key: (k) => k, value: (k) => simplify2[k]);
  for (int i = 0; i < sortedMap2.length; i++) {
    sortedMap2[keys[i]] = raw[keys[i]];
  }
  favArtists(sortedMap2);
  favAlbums(sortedMap2);
  topPlayed(sortedMap2);
  recentlyPlayed(sortedMap);
  neverPlayed(sortedMap2);
}

favArtists(Map raw) {
  List keys = raw.keys.toList();
  List kick = [];

  for (int i = 0; i < keys.length; i++) {
    if (raw[keys[i]][1] != "<unknown>") {
      for (int o = 0; o < allAlbums.length; o++) {
        if (raw[keys[i]][2].toString().toUpperCase() ==
            allAlbums[o].album.toString().toUpperCase()) {
          kick.add(allAlbums[o].artist.toString().toUpperCase());
        }
      }
    }
  }
  mansionArtists = kick.reversed.toSet().toList();
}

favAlbums(Map raw) {
  List keys = raw.keys.toList();
  List prepare = [];
  for (int i = 0; i < raw.length; i++) {
    prepare.add(raw[keys[i]][2].toString().toUpperCase());
  }
  prepare = prepare.reversed.toSet().toList();
  for (int a = 0; a < prepare.length; a++) {
    takingme:
    for (int o = 0; o < allAlbums.length; o++) {
      if (prepare[a] == allAlbums[o].album.toString().toUpperCase()) {
        mansionAlbums.add(allAlbums[o]);
        break takingme;
      }
    }
  }
}

recentlyPlayed(Map raw) async {
  List keys = raw.keys.toList();
  keys = keys.reversed.toSet().toList();
  for (int i = 0; i < keys.length; i++) {
    for (int o = 0; o < songList.length; o++) {
      if (keys[i] == songList[o].data) {
        recentPlayed.add(songList[o]);
        MediaItem item = MediaItem(
            id: songList[o].data,
            album: songList[o].album,
            artist: songList[o].artist,
            duration: Duration(milliseconds: getDuration(songList[o])!),
            artUri: Uri.file(
              (musicBox.get("artworksPointer") ?? {})[songList[o].id] == null
                  ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                  : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[songList[o].id]}.jpeg",
            ),
            title: songList[o].title,
            extras: {"id": songList[o].id});
        recentPlayedMediaItems.add(item);
      }
    }
  }
  recentPlayedLength = recentPlayed.length;
}

neverPlayed(Map raw) async {
  List everPlayed = [];
  for (int i = 0; i < songList.length; i++) {
    everPlayed.add(songList[i]);
  }
  List keys = raw.keys.toList();
  for (int i = 0; i < keys.length; i++) {
    for (int o = 0; o < everPlayed.length; o++) {
      if (keys[i] == everPlayed[o].data) {
        everPlayed.removeAt(o);
      }
    }
  }
  if (songList.isNotEmpty) {
    if (everPlayed.isNotEmpty) {
      for (int i = 0; i < 11; i++) {
        int randomNumber = random.nextInt(everPlayed.length);
        everPlayedLimited.add(everPlayed[randomNumber]);
        MediaItem item = MediaItem(
            id: everPlayedLimited[i].data,
            album: everPlayedLimited[i].album,
            artist: everPlayedLimited[i].artist,
            duration:
                Duration(milliseconds: getDuration(everPlayedLimited[i])!),
            artUri: Uri.file(
              (musicBox.get("artworksPointer") ??
                          {})[everPlayedLimited[i].id] ==
                      null
                  ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                  : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[everPlayedLimited[i].id]}.jpeg",
            ),
            title: everPlayedLimited[i].title,
            extras: {"id": everPlayedLimited[i].id});
        everPlayedLimitedMediaItems.add(item);
      }
    } else {}
  }
}

topPlayed(Map raw) async {
  List keys = raw.keys.toList();
  keys = keys.reversed.toList();
  for (int a = 0; a < keys.length; a++) {
    for (int q = 0; q < songList.length; q++) {
      if (keys[a] == songList[q].data) {
        alwaysPlayed.add(songList[q]);
        MediaItem item = MediaItem(
            id: songList[q].data,
            album: songList[q].album,
            artist: songList[q].artist,
            duration: Duration(milliseconds: getDuration(songList[q])!),
            artUri: Uri.file(
              (musicBox.get("artworksPointer") ?? {})[songList[q].id] == null
                  ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                  : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[songList[q].id]}.jpeg",
            ),
            title: songList[q].title,
            extras: {"id": songList[q].id});
        alwaysPlayedMediaItems.add(item);
      }
    }
  }
}

updateRecentlyPlayed(song) async {
  if (recentPlayed.isEmpty) {
    recentPlayed.add(song);
    MediaItem item = MediaItem(
        id: song.data,
        album: song.album,
        artist: song.artist,
        duration: Duration(milliseconds: getDuration(song)!),
        artUri: Uri.file(
          (musicBox.get("artworksPointer") ?? {})[song.id] == null
              ? "${applicationFileDirectory.path}/artworks/null.jpeg"
              : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[song.id]}.jpeg",
        ),
        title: song.title,
        extras: {"id": song.id});
    recentPlayedMediaItems.add(item);
  } else {
    if (recentPlayed[0] != song) {
      recentPlayed.insert(0, song);
      MediaItem item = MediaItem(
          id: song.data,
          album: song.album,
          artist: song.artist,
          duration: Duration(milliseconds: getDuration(song)!),
          artUri: Uri.file(
            (musicBox.get("artworksPointer") ?? {})[song.id] == null
                ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[song.id]}.jpeg",
          ),
          title: song.title,
          extras: {"id": song.id});
      recentPlayedMediaItems.add(item);
    }
  }
}

updateMansion() async {
  await updateData(nowMediaItem.id);
  for (int i = 0; i < songList.length; i++) {
    if (songList[i].data == nowMediaItem.id) {
      await updateRecentlyPlayed(songList[i]);
      break;
    }
  }

  if (globalMansionConsumer != null) {
    recentPlayedLength = recentPlayed.length > 6 ? 6 : recentPlayed.length;
    globalMansionConsumer.rawNotify();
  }
}

updateData(data) async {
  Map dBase = musicBox.get('crossfire') ?? {};
  int recent = dBase.length + 1;
  if (dBase[data] == null) {
    // [numberOfTimes, artist, album, historyIndex]
    dBase[data] = [1, nowMediaItem.artist, nowMediaItem.album, recent];
  } else {
    int times = dBase[data][0];
    times += 1;
    dBase[data] = [times, nowMediaItem.artist, nowMediaItem.album, recent];
  }
  musicBox.put('crossfire', dBase);
}
