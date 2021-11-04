import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/native/go_native.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import '../page_backend/artists_back.dart';
import 'package:phoenix/src/beginning/pages/genres/genres.dart';
import 'package:phoenix/src/beginning/pages/genres/genres_inside.dart';
import 'package:phoenix/src/beginning/pages/playlist/playlist_inside.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/artwork.dart';
import 'package:phoenix/src/beginning/utilities/screenshot_ui.dart';
import '../page_backend/mansion_back.dart';
import 'package:phoenix/src/beginning/utilities/scraping/lyrics_scrape.dart';
import '../filters.dart';

int? indexofcurrent;
String? lyricsDat = " ";
String? rnAccessing;
bool onGoingProcess = false;
bool isPlaying = false;

audioServiceStream() async {
  audioHandler.playbackState.listen((event) {
    if (event.playing) {
      if (!isPlaying) {
        isPlaying = true;
        if (isPlayerShown) {
          animatedPlayPause.reverse();
          if (!bgPhoenixVisualizer) {
            if (isFlashin) {
              kotlinVisualizer();
            }
          }
        }
      }
    } else {
      if (isPlaying) {
        isPlaying = false;
        if (isPlayerShown) {
          animatedPlayPause.forward();
          if (!bgPhoenixVisualizer) {
            if (isFlashin) {
              stopkotlinVisualizer();
            }
          }
        }
      }
    }
  });
  audioHandler.mediaItem.listen((mediaItem) {
    if (nowMediaItem != mediaItem && mediaItem != null) {
      nowMediaItem = mediaItem;
      updateStuffs();
    }
  });
}

updateStuffs() async {
  await playerontap();
  if (onLyrics) lyricsFoo();
  updateMansion();
  updateThings();
}

playThis(int indexOfSong, rnAccess) async {
  lyricsDat = "";
  if (rnAccess == "all") {
    rnAccessing = "all";
    await goToAudioService(indexOfSong, songList, songListMediaItems);
  } else if (rnAccess == "album") {
    rnAccessing = "album";
    await goToAudioService(
        indexOfSong, insideInAlbumSongs as List<SongModel>?, albumMediaItems);
  } else if (rnAccess == "artist") {
    rnAccessing = "artist";
    await goToAudioService(indexOfSong, insideInArtistsSongs, artistMediaItems);
  } else if (rnAccess == "genre") {
    rnAccessing = "genre";
    await goToAudioService(
        indexOfSong, insidegenreSongs as List<SongModel>?, genreMediaItems);
  } else if (rnAccess == "recent") {
    rnAccessing = "recent";
    await goToAudioService(indexOfSong, recentPlayed, recentPlayedMediaItems);
  } else if (rnAccess == "mostly") {
    rnAccessing = "mostly";
    await goToAudioService(indexOfSong, alwaysPlayed, alwaysPlayedMediaItems);
  } else if (rnAccess == "never") {
    rnAccessing = "never";
    await goToAudioService(
        indexOfSong, everPlayedLimited, everPlayedLimitedMediaItems);
  } else if (rnAccess == "playlist") {
    rnAccessing = "playlist";
    await goToAudioService(
        indexOfSong, insideplaylistSongsInside, playlistMediaItems);
  }
  if (shuffleSelected) {
    await shuffleMode();
  }
  readyPlay();
  await playerontap();
  if (onLyrics) lyricsFoo();
  updateThings();
  indexofcurrent = indexOfSong;
}

void lyricsFoo() async {
  if (!(musicBox.get("isolation") == null
      ? false
      : musicBox.get('isolation'))) {
    if (musicBox.get('offlineLyrics') == null
        ? false
        : musicBox.get('offlineLyrics').containsKey(nowMediaItem.id)) {
      lyricsDat = musicBox.get('offlineLyrics')[nowMediaItem.id];
      if (lyricsDat == "Couldn't find any matching lyrics." ||
          lyricsDat == "" ||
          lyricsDat == " ") {
        holdUpLyrics();
      }
    } else {
      holdUpLyrics();
    }
  }
}

void addToQueue(MediaItem mediaitem) async {
  audioHandler.addQueueItem(mediaitem);
}

void pauseResume() async {
  if (isPlaying) {
    audioHandler.pause();
  } else {
    audioHandler.play();
  }
}

Future<void> goToAudioService(int indexOfSong, List<SongModel>? allSong,
    List<MediaItem> listOfMediaItems) async {
  nowQueue = listOfMediaItems.sublist(indexOfSong) +
      listOfMediaItems.sublist(0, indexOfSong);
  nowMediaItem = nowQueue[0];
  if (nowQueue[0].duration == const Duration(milliseconds: 0)) {
    nowQueue.removeAt(0);
  }
  await audioHandler.updateQueue(nowQueue);
}

void readyPlay() {
  audioHandler.play();
  updateMansion();
}

Future<void> updateThings() async {
  if (isFlashin) {
    if (!activeSession) {
      kotlinVisualizer();
    }
  }

  if (musicBox.get("wallpx") ?? false) {
    await screenShotUI(false);
    await checkWallpaperSupport();
  }
}

Future<void> loopMode() async {
  if (loopSelected) {
    await audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
  } else {
    await audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
  }
}

Future<void> shuffleMode() async {
  if (shuffleSelected) {
    await audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
  } else {
    await audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
  }
}

void holdUpLyrics() async {
  String artistsLyric = nowMediaItem.artist.toString();
  String songNameLyric = nowMediaItem.title.toString();
  songNameLyric = aestheticText(songNameLyric);
  if (artistsLyric == "<UNKNOWN>") {
    artistsLyric = " ";
  }
  await lyricsFetch(artistsLyric, songNameLyric, nowMediaItem.id);
  globalBigNow.rawNotify();
}

void saveLyrics(songPath, lyric) async {
  Map allData = musicBox.get('offlineLyrics') ?? {};
  allData[songPath] = lyric;
  await musicBox.put('offlineLyrics', allData);
}

int? getDuration(SongModel data) {
  try {
    return data.duration;
  } catch (e) {
    return 0;
  }
}
