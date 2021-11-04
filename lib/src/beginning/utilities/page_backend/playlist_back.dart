import 'package:audio_service/audio_service.dart';
import 'package:phoenix/src/beginning/pages/playlist/add_songs.dart';
import 'package:phoenix/src/beginning/pages/playlist/playlist_inside.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';

fetchPlaylistSongs(String? playlistName) {
  playlistMediaItems = [];
  playlistSongsInside = [];
  playListSongsId = [];
  var musBox = musicBox.get('playlists')[playlistName];
  for (int i = 0; i < musBox.length; i++) {
    for (int o = 0; o < songList.length; o++) {
      if (musBox[i] == songList[o].data) {
        if (musicBox.get("customScan") ?? false) {
          gotOne:
          if (musicBox.get('customLocations') != null) {
            for (int a = 0; a < musicBox.get('customLocations').length; a++) {
              if (songList[o]
                  .data
                  .contains(musicBox.get('customLocations')[a])) {
                playListSongsId.add(songList[o].data);
                playlistSongsInside.add(songList[o]);
                MediaItem item = MediaItem(
                    id: songList[o].data,
                    album: songList[o].album,
                    artist: songList[o].artist,
                    duration: Duration(milliseconds: getDuration(songList[o])!),
                    artUri: Uri.file(
                      (musicBox.get("artworksPointer") ?? {})[songList[o].id] ==
                              null
                          ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                          : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[songList[o].id]}.jpeg",
                    ),
                    title: songList[o].title,
                    extras: {"id": songList[o].id});
                playlistMediaItems.add(item);
                break gotOne;
              }
            }
          }
        } else {
          playListSongsId.add(songList[o].data);
          playlistSongsInside.add(songList[o]);
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
          playlistMediaItems.add(item);
        }
      }
    }
  }
}

void newPlaylist(String? playListName, List queue) {
  Map check = musicBox.get('playlists') ?? {};
  check[playListName] = queue;
  musicBox.put('playlists', check);
}

void removePlaylists(name) {
  Map check = musicBox.get('playlists');
  check.remove(name);
  musicBox.put('playlists', check);
}

void updateQueuePlayList(name, updatedQueue) {
  List dats = [];
  for (int i = 0; i < updatedQueue.length; i++) {
    dats.add(updatedQueue[i].data);
  }
  Map check = musicBox.get('playlists');
  check[name] = dats;
  musicBox.put('playlists', check);
}

playlistSongsSelected({required bool fresh, playlistName}) {
  if (fresh) {
    playListCheck = [];
    for (int i = 0; i < songList.length; i++) {
      playListCheck.add(false);
    }
  } else {
    List rain = musicBox.get('playlists')[playlistName];
    playListCheck = [];
    for (int i = 0; i < songList.length; i++) {
      playListCheck.add(false);
    }
    for (int i = 0; i < rain.length; i++) {
      for (int o = 0; o < songList.length; o++) {
        if (songList[o].data == rain[i]) {
          playListCheck[o] = true;
        }
      }
    }
  }
}
