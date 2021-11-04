import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';

List<String> allArtists = [];
Map<String, List<dynamic>> artistData = {};
List<SongModel> inArtistsSongs = [];
List<SongModel>? insideInArtistsSongs = [];
Map artistsAlbums = {};
List<MediaItem> artistMediaItems = [];
int numberOfSongsOfArtist = 0;

// IMPURE artist method. Get all the artists from the albums.
gettinArtists() async {
  allArtists = [];
  artistData = {};
  inArtistsSongs = [];
  insideInArtistsSongs = [];
  artistsAlbums = {};
  List<String> mainList = [];

  for (int i = 0; i < allAlbums.length; i++) {
    mainList.add(allAlbums[i].artist!.toUpperCase());
  }
  var result = mainList.toSet().toList();
  result.sort();
  allArtists = result;

  if (musicBox.get("stopUnknown") ?? false) {
    allArtists.remove("<UNKNOWN>");
  }
}

gettinArtistsAlbums() async {
  for (int a = 0; a < allArtists.length; a++) {
    String artistRN = allArtists[a].toLowerCase();
    List emall = [];
    for (int i = 0; i < allAlbums.length; i++) {
      if (allAlbums[i].artist!.toLowerCase() == artistRN) {
        emall.add(allAlbums[i]);
      }
    }
    artistData[artistRN.toLowerCase()] = emall;
  }
}

artistsAllSongs(String who) async {
  inArtistsSongs = [];
  artistMediaItems = [];

  for (int i = 0; i < songList.length; i++) {
    if (songList[i].artist!.toLowerCase() == who.toLowerCase()) {
      inArtistsSongs.add(songList[i]);
      MediaItem item = MediaItem(
          id: songList[i].data,
          album: songList[i].album,
          artist: songList[i].artist,
          duration: Duration(milliseconds: getDuration(songList[i])!),
          artUri: Uri.file(
            (musicBox.get("artworksPointer") ?? {})[songList[i].id] == null
                ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[songList[i].id]}.jpeg",
          ),
          title: songList[i].title,
          extras: {"id": songList[i].id});
      artistMediaItems.add(item);
    }
  }

  numberOfSongsOfArtist = inArtistsSongs.length;
}

smartArtistsArts() {
  for (int i = 0; i < allArtists.length; i++) {
    for (int o = 0; o < allAlbums.length; o++) {
      if (allArtists[i] == allAlbums[o].artist.toString().toUpperCase()) {
        List add = artistsAlbums[allArtists[i]] ?? [];
        add.add(allAlbums[o].album);
        artistsAlbums[allArtists[i]] = add;
      }
    }
  }
}
