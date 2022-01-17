import 'dart:io';
import 'dart:typed_data';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import '../../pages/albums/albums.dart';
import 'package:flutter/foundation.dart';

List<AlbumModel> allAlbums = [];
List<String?> allAlbumsName = [];
Map<String, Uint8List?> albumsArts = {};
List<SongModel> inAlbumSongs = [];
List inAlbumSongsArtIndex = [];
List? insideInAlbumSongs = [];
int? numberOfAlbumArtist;
List<MediaItem> albumMediaItems = [];
Map<int, Uint8List?> artworksData = {};
List<int> allSongIds = [];

gettinAlbums() async {
  allAlbums = [];
  albumsArts = {};
  inAlbumSongs = [];
  inAlbumSongsArtIndex = [];
  insideInAlbumSongs = [];
  allAlbumsName = [];
  List<AlbumModel> albumsIn = await OnAudioQuery().queryAlbums();

  List rmDup = [];
  for (int i = 0; i < albumsIn.length; i++) {
    if (!rmDup.contains(albumsIn[i].album.toUpperCase())) {
      rmDup.add(albumsIn[i].album.toUpperCase());
      if (musicBox.get('customScan') ?? false) {
        if (specificAlbums.contains(albumsIn[i].album.toUpperCase())) {
          allAlbums.add(albumsIn[i]);
          allAlbumsName.add(albumsIn[i].album);
        }
      } else {
        allAlbums.add(albumsIn[i]);
        allAlbumsName.add(albumsIn[i].album);
      }
    }
  }
}

gettinAlbumsArts() async {
  List<String> albumswoArt = [];
  if (!await Directory("${applicationFileDirectory.path}/artworks").exists()) {
    await Directory("${applicationFileDirectory.path}/artworks").create();
  }
  if (!await File("${applicationFileDirectory.path}/artworks/null.jpeg")
      .exists()) {
    ByteData bytes = await rootBundle.load("assets/res/default.jpg");
    Uint8List data = bytes.buffer.asUint8List();
    await File("${applicationFileDirectory.path}/artworks/null.jpeg")
        .writeAsBytes(data);
  }
  for (int i = 0; i < allAlbums.length; i++) {
    if (await File(
            "${applicationFileDirectory.path}/artworks/${allAlbums[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg")
        .exists()) {
      albumsArts[allAlbums[i].album] = await File(
              "${applicationFileDirectory.path}/artworks/${allAlbums[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg")
          .readAsBytes();
    } else {
      albumsArts[allAlbums[i].album] = await OnAudioQuery().queryArtwork(
          allAlbums[i].id, ArtworkType.ALBUM,
          format: ArtworkFormat.JPEG, size: 350);
      if (albumsArts[allAlbums[i].album] != null) {
        await File(
                "${applicationFileDirectory.path}/artworks/${allAlbums[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg")
            .writeAsBytes(albumsArts[allAlbums[i].album]!,
                mode: FileMode.write);
      } else {
        albumswoArt.add(allAlbums[i].album);
      }
    }
  }
  musicBox.put("AlbumsWithoutArt", albumswoArt);
}

albumSongs() async {
  inAlbumSongs = await OnAudioQuery().queryAudiosFrom(
      AudiosFromType.ALBUM, allAlbums[passedIndexAlbum!].album,
      sortType: SongSortType.DATE_ADDED);
  for (int i = 0; i < inAlbumSongs.length; i++) {
    MediaItem mi = MediaItem(
        id: inAlbumSongs[i].data,
        album: inAlbumSongs[i].album,
        title: inAlbumSongs[i].title,
        artist: inAlbumSongs[i].artist,
        duration: Duration(milliseconds: getDuration(inAlbumSongs[i])!),
        artUri: Uri.file(
          (musicBox.get("artworksPointer") ?? {})[inAlbumSongs[i].id] == null
              ? "${applicationFileDirectory.path}/artworks/null.jpeg"
              : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[inAlbumSongs[i].id]}.jpeg",
        ),
        extras: {"id": inAlbumSongs[i].id});
    albumMediaItems.add(mi);
    inAlbumSongsArtIndex.add(i);
  }
}

gettinSongArts() async {
  Map artworksPointer = {};
  List<Uint8List?> allArtworks = [];
  List allSongIds = [];
  List cachedIds = musicBox.get("artworksPointer") == null
      ? []
      : musicBox.get("artworksPointer").keys.toList();
  artworksData = {};
  for (int i = 0; i < songList.length; i++) {
    allSongIds.add(songList[i].id);
  }
  allSongIds.sort();
  cachedIds.sort();
  bool hasNewInCustom(List small, List big) {
    for (int i = 0; i < small.length; i++) {
      if (!big.contains(small[i])) return true;
    }
    return false;
  }

  List nowList = allSongIds;
  if (listEquals(allSongIds, cachedIds) ||
      (((musicBox.get("customScan") ?? false) ||
              (musicBox.get("clutterFree") ?? false)) &&
          !hasNewInCustom(nowList, cachedIds))) {
    List allArtworksName = [];
    if ((musicBox.get("customScan") ?? false) ||
        (musicBox.get("clutterFree") ?? false)) {
      Map pointers = musicBox.get("artworksPointer") ?? {};
      for (int i = 0; i < allSongIds.length; i++) {
        allArtworksName.add(pointers[allSongIds[i]]);
      }
    } else {
      allArtworksName = musicBox.get("artworksName") ?? [];
    }

    debugPrint("allCache");
    allArtworksName.removeWhere((element) => element == null);
    for (int i = 0; i < allArtworksName.length; i++) {
      artworksData[allArtworksName[i]] = await File(
              "${applicationFileDirectory.path}/artworks/songarts/${allArtworksName[i]}.jpeg")
          .readAsBytes();
    }
  } else {
    bool isDuplicate(Uint8List? artwork, int id) {
      List artworkKeys = artworksData.values.toList();
      for (int a = 0; a < artworkKeys.length; a++) {
        if (listEquals(artwork, artworkKeys[a])) {
          artworksPointer[id] = artworksData.keys.toList()[a];
          return true;
        }
      }
      artworksData[id] = artwork;
      artworksPointer[id] = id;
      allArtworks.add(artwork);
      return false;
    }

    if (cachedIds.isEmpty) {
      for (int i = 0; i < allSongIds.length; i++) {
        Uint8List? artwork = await OnAudioQuery()
            .queryArtwork(allSongIds[i], ArtworkType.AUDIO, size: 350);
        if (artwork == null) {
          artworksPointer[allSongIds[i]] = null;
          allArtworks.add(null);
          artworksData[allSongIds[i]] = null;
        } else {
          isDuplicate(artwork, allSongIds[i]);
        }
      }
      if (!await Directory("${applicationFileDirectory.path}/artworks/songarts")
          .exists()) {
        await Directory("${applicationFileDirectory.path}/artworks/songarts")
            .create();
      }
      final List<int> dataKey = artworksData.keys.toList();
      final List<Uint8List?> dataValue = artworksData.values.toList();
      for (int i = 0; i < artworksData.length; i++) {
        if (!(await File(
                    "${applicationFileDirectory.path}/artworks/songarts/${dataKey[i]}.jpeg")
                .exists()) &&
            dataValue[i] != null) {
          await File(
                  "${applicationFileDirectory.path}/artworks/songarts/${dataKey[i]}.jpeg")
              .writeAsBytes(dataValue[i]!);
        }
      }
      List<int> allImageNames = [];
      for (int i = 0; i < artworksData.length; i++) {
        if (dataValue[i] != null) {
          allImageNames.add(dataKey[i]);
        }
      }
      musicBox.put("artworksPointer", artworksPointer);
      musicBox.put("artworksName", allImageNames);
      refresh = true;
    } else {
      debugPrint("dirty-cache");
      artworksPointer = musicBox.get("artworksPointer");
      List newIds =
          allSongIds.where((element) => !cachedIds.contains(element)).toList();
      for (int i = 0; i < newIds.length; i++) {
        refresh = true;
        Uint8List? artwork = await OnAudioQuery()
            .queryArtwork(newIds[i], ArtworkType.AUDIO, size: 350);
        if (artwork == null) {
          artworksPointer[newIds[i]] = null;
          allArtworks.add(null);
          artworksData[newIds[i]] = null;
        } else {
          isDuplicate(artwork, newIds[i]);
        }
      }
      if (!await Directory("${applicationFileDirectory.path}/artworks/songarts")
          .exists()) {
        await Directory("${applicationFileDirectory.path}/artworks/songarts")
            .create();
      }
      final List<int> dataKey = artworksData.keys.toList();
      final List<Uint8List?> dataValue = artworksData.values.toList();
      for (int i = 0; i < artworksData.length; i++) {
        if (!(await File(
                    "${applicationFileDirectory.path}/artworks/songarts/${dataKey[i]}.jpeg")
                .exists()) &&
            dataValue[i] != null) {
          await File(
                  "${applicationFileDirectory.path}/artworks/songarts/${dataKey[i]}.jpeg")
              .writeAsBytes(dataValue[i]!);
        }
      }
      List<int> allImageNames = musicBox.get("artworksName") ?? [];
      for (int i = 0; i < artworksData.length; i++) {
        if (dataValue[i] != null) {
          allImageNames.add(dataKey[i]);
        }
      }
      musicBox.put("artworksPointer", artworksPointer);
      musicBox.put("artworksName", allImageNames);
      for (int i = 0; i < allImageNames.length; i++) {
        artworksData[allImageNames[i]] = await File(
                "${applicationFileDirectory.path}/artworks/songarts/${allImageNames[i]}.jpeg")
            .readAsBytes();
      }
    }
  }
  allSongIds = musicBox.get("artworksName");
}
