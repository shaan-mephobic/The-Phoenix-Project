import 'dart:io';
import 'dart:typed_data';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/Begin/begin.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import '../../pages/albums/albums.dart';

List<AlbumModel> allAlbums = [];
List<String> allAlbumsName = [];
Map<String, Uint8List> albumsArts = {};
List<SongModel> inAlbumSongs = [];
List inAlbumSongsArtIndex = [];
List insideInAlbumSongs = [];
int numberOfAlbumArtist;
List<MediaItem> albumMediaItems = [];

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
            .writeAsBytes(albumsArts[allAlbums[i].album], mode: FileMode.write);
      } else {
        albumswoArt.add(allAlbums[i].album);
      }
    }
  }
  musicBox.put("AlbumsWithoutArt", albumswoArt);
}

albumSongs() async {
  inAlbumSongs = await OnAudioQuery()
      .queryAudiosFrom(AudiosFromType.ALBUM, allAlbums[passedIndexAlbum].album);
  for (int i = 0; i < inAlbumSongs.length; i++) {
    MediaItem mi = MediaItem(
        id: inAlbumSongs[i].data,
        album: inAlbumSongs[i].album,
        title: inAlbumSongs[i].title,
        artist: inAlbumSongs[i].artist,
        duration: Duration(milliseconds: getDuration(inAlbumSongs[i])),
        artUri: Uri.file(allAlbumsName.contains(inAlbumSongs[i].album)
            ? musicBox.get("AlbumsWithoutArt") == null
                ? "${applicationFileDirectory.path}/artworks/${inAlbumSongs[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
                : musicBox.get("AlbumsWithoutArt").contains(inAlbumSongs[i].album)
                    ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                    : "${applicationFileDirectory.path}/artworks/${inAlbumSongs[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
            : "${applicationFileDirectory.path}/artworks/null.jpeg"),
        extras: {"id": inAlbumSongs[i].id});
    albumMediaItems.add(mi);
    inAlbumSongsArtIndex.add(i);
  }
}
