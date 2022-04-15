import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/pages/genres/genres.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';

List<GenreModel> allgenres = [];
Map<String, List<SongModel>> insideAllGenreData = {};

gettinGenres() async {
  insideAllGenreData = {};
  allgenres = [];
  List<GenreModel> genres = await OnAudioQuery().queryGenres();
  if (musicBox.get('customScan') ?? false) {
    for (int i = 0; i < genres.length; i++) {
      List tempGenreSongs = await OnAudioQuery()
          .queryAudiosFrom(AudiosFromType.GENRE, genres[i].genre);
      for (int o = 0; o < tempGenreSongs.length; o++) {
        if (musicBox.get('customLocations') != null) {
          for (int a = 0; a < musicBox.get('customLocations').length; a++) {
            if (tempGenreSongs[o]
                .data
                .toString()
                .contains(musicBox.get('customLocations')[a])) {
              if (insideAllGenreData[genres[i].genre] == null) {
                insideAllGenreData[genres[i].genre] = [tempGenreSongs[o]];
              } else {
                insideAllGenreData[genres[i].genre]!.add(tempGenreSongs[o]);
              }
              allgenres.add(genres[i]);
            }
          }
        }
      }
    }
  } else {
    allgenres = genres;
  }
}

putinGenreInMediaItem() {
  for (int i = 0; i < genreSongs!.length; i++) {
    MediaItem item = MediaItem(
        id: genreSongs![i].data,
        album: genreSongs![i].album,
        artist: genreSongs![i].artist,
        duration: Duration(milliseconds: getDuration(genreSongs![i])!),
        artUri: Uri.file(
          (musicBox.get("artworksPointer") ?? {})[genreSongs![i].id] == null
              ? "${applicationFileDirectory.path}/artworks/null.jpeg"
              : "${applicationFileDirectory.path}/artworks/songarts/${(musicBox.get("artworksPointer") ?? {})[genreSongs![i].id]}.jpeg",
        ),
        title: genreSongs![i].title,
        extras: {"id": genreSongs![i].id});
    genreMediaItems.add(item);
  }
}

fetchGenreSongs(int index) async {
  genreSongs = [];
  genreMediaItems = [];
  if (musicBox.get('customScan') ?? false) {
    int sort = (musicBox.get('genreSort') ?? [0, 4])[0];
    int order = (musicBox.get('genreSort') ?? [0, 4])[1];
    genreSongs = insideAllGenreData.values.toList()[index];
    if (sort == 0) {
      genreSongs!.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    } else if (sort == 1) {
      genreSongs!
          .sort((a, b) => (a.dateAdded ?? 0).compareTo((b.dateAdded ?? 0)));
    } else if (sort == 2) {
      genreSongs!.sort((a, b) => (a.album ?? "")
          .toLowerCase()
          .compareTo((b.album ?? "").toLowerCase()));
    } else {
      genreSongs!.sort((a, b) => (a.artist ?? "")
          .toLowerCase()
          .compareTo((b.artist ?? "").toLowerCase()));
    }
    if (order == 5) {
      genreSongs = genreSongs!.reversed.toList();
    }
  } else {
    int sort = (musicBox.get('genreSort') ?? [0, 4])[0];
    genreSongs = await OnAudioQuery().queryAudiosFrom(
        AudiosFromType.GENRE, allgenres[index].genre,
        sortType: sort == 0
            ? SongSortType.TITLE
            : sort == 1
                ? SongSortType.DATE_ADDED
                : sort == 2
                    ? SongSortType.ALBUM
                    : SongSortType.ARTIST,
        ignoreCase: true,
        orderType: (musicBox.get('genreSort') ?? [0, 4])[1] == 4
            ? OrderType.ASC_OR_SMALLER
            : OrderType.DESC_OR_GREATER);
  }
  putinGenreInMediaItem();
}
