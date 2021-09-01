import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import '../../begin.dart';

List<String> allArtists = [];
Map<String, List<dynamic>> artistData = {};
List<SongModel> inArtistsSongs = [];
List<SongModel> insideInArtistsSongs = [];
Map artistsAlbums = {};
List<MediaItem> artistMediaItems = [];
int numberOfSongsOfArtist = 0;

// PURE artist method but has bugs with THE EDEN PROJECT

// gettin_artists() async {
//   var artistic = await OnAudioQuery().queryArtists(
//       ArtistSortType.DEFAULT, OrderType.ASC_OR_SMALLER, UriType.EXTERNAL);
//   for (int i = 0; i < artistic.length; i++) {
//     print(artistic[i].artistName);
//     if (is_not_albumless(artistic[i])) {
//       all_artists.add(artistic[i]);
//     }
//   }
// }

// is_not_albumless(e) {
//   bool t_or_f = false;
//   print(e.artistName);
//   nig:
//   for (int i = 0; i < all_albums.length; i++) {
//     if (all_albums[i].artist.toUpperCase() == e.artistName.toUpperCase()) {
//       t_or_f = true;
//       break nig;
//     }
//   }
//   return t_or_f;
// }

// gettin_artists_albums() async {
//   for (int a = 0; a < all_artists.length; a++) {
//     String artistRN = all_artists[a].artistName;
//     List emall = [];
//     for (int i = 0; i < all_albums.length; i++) {
//       if (all_albums[i].artist.toUpperCase() == artistRN.toUpperCase()) {
//         // artist_data.add(all_albums[i].albumName);
//         emall.add(all_albums[i]);
//       }
//     }
//     artist_data[artistRN] = emall;
//   }
// }

// artists_all_songs() {
//   for (int i = 0;
//       i < artist_data[all_artists[artist_passed].artistName].length;
//       i++) {
//     var ok = artist_data[all_artists[artist_passed].artistName][i].albumName;
//     for (int i = 0; i < songList.length; i++) {
//       if (songList[i].album == ok) {
//         in_artists_songs.add(songList[i]);
//       }
//     }
//   }
// // Above method uses only songs that are in albums and doesn't consider album less.
// // add customization to only show album having artists so you can unshow illenium of individuals.
// // Workaround for now is by default not show songs like that
//   return in_artists_songs.length;
// }

// IMPURE artist method with album
gettinArtists() async {
  allArtists = [];
  artistData = {};
  inArtistsSongs = [];
  insideInArtistsSongs = [];
  artistsAlbums = {};
  List<String> mainList = [];

  for (int i = 0; i < allAlbums.length; i++) {
    mainList.add(allAlbums[i].artist.toUpperCase());
  }
  var result = mainList.toSet().toList();
  result.sort();
  allArtists = result;

  if (musicBox.get("stopUnknown") ?? false) {
    allArtists.remove("<UNKNOWN>");
  }
  // print(allArtists);
}

gettinArtistsAlbums() async {
  for (int a = 0; a < allArtists.length; a++) {
    String artistRN = allArtists[a].toLowerCase();
    List emall = [];
    for (int i = 0; i < allAlbums.length; i++) {
      if (allAlbums[i].artist.toLowerCase() == artistRN) {
        // artist_data.add(all_albums[i].albumName);
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
    if (songList[i].artist.toLowerCase() == who.toLowerCase()) {
  
      inArtistsSongs.add(songList[i]);
      MediaItem item = MediaItem(
          id: songList[i].data,
          album: songList[i].album,
          artist: songList[i].artist,
          duration: Duration(milliseconds: getDuration(songList[i])),
          artUri: Uri.file(

         
                          allAlbumsName.contains(songList[i].album)
              ? musicBox.get("AlbumsWithoutArt") == null
                  ? "${applicationFileDirectory.path}/artworks/${songList[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
                  : musicBox.get("AlbumsWithoutArt").contains(songList[i].album)
                      ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                      : "${applicationFileDirectory.path}/artworks/${songList[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
              : "${applicationFileDirectory.path}/artworks/null.jpeg"
              ),
          title: songList[i].title,
          extras: {"id": songList[i].id});
      artistMediaItems.add(item);
    
    }
  }

  numberOfSongsOfArtist = inArtistsSongs.length;
  
}

smartArtistsArts() {
  // cap fix
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
