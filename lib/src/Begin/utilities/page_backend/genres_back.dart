import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/begin/pages/genres/genres.dart';
import 'package:phoenix/src/begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/begin/utilities/global_variables.dart';
import 'albums_back.dart';

List<GenreModel> allgenres = [];
Map<String, List<SongModel>> insideAllGenreData = {};

gettinGenres() async {
  allgenres = [];
  var generica = await OnAudioQuery().queryGenres();
  for (int i = 0; i < generica.length; i++) {
    if (generica[i].genre != null) {
      if (musicBox.get('customScan') ?? false) {
        List tempGenreSongs = await OnAudioQuery()
            .queryAudiosFrom(AudiosFromType.GENRE, generica[i].genre);
        // print(tempGenreSongs);
        for (int o = 0; o < tempGenreSongs.length; o++) {
          if (musicBox.get('customLocations') != null) {
            for (int a = 0; a < musicBox.get('customLocations').length; a++) {
              if (tempGenreSongs[o]
                  .data
                  .toString()
                  .contains(musicBox.get('customLocations')[a])) {
                if (insideAllGenreData[generica[i].genre] == null) {
                  insideAllGenreData[generica[i].genre] = [tempGenreSongs[o]];
                } else {
                  insideAllGenreData[generica[i].genre].add(tempGenreSongs[o]);
                }
                if (generica[i].genre != null) allgenres.add(generica[i]);
              }
            }
          }
        }
      } else {
        if (generica[i].genre != null) allgenres.add(generica[i]);
      }
    }
  }
}

putinGenreInMediaItem() {
  for (int i = 0; i < genreSongs.length; i++) {
    MediaItem item = MediaItem(
        id: genreSongs[i].data,
        album: genreSongs[i].album,
        artist: genreSongs[i].artist,
        duration: Duration(milliseconds: getDuration(genreSongs[i])),
        artUri: Uri.file(allAlbumsName.contains(genreSongs[i].album)
            ? musicBox.get("AlbumsWithoutArt") == null
                ? "${applicationFileDirectory.path}/artworks/${genreSongs[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
                : musicBox.get("AlbumsWithoutArt").contains(genreSongs[i].album)
                    ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                    : "${applicationFileDirectory.path}/artworks/${genreSongs[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
            : "${applicationFileDirectory.path}/artworks/null.jpeg"),
        title: genreSongs[i].title,
        extras: {"id": genreSongs[i].id});
    genreMediaItems.add(item);
  }
}
