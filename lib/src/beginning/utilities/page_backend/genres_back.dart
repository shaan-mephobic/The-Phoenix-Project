import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/pages/genres/genres.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';

List<GenreModel> allgenres = [];
Map<String, List<SongModel>> insideAllGenreData = {};

gettinGenres() async {
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
