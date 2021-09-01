import 'package:permission_handler/permission_handler.dart';
import '../widgets/dialogues/on_hold.dart';

editSong(songFile, title, album, artist, genre) async {
  if (await Permission.storage.request().isGranted &&
      await Permission.manageExternalStorage.request().isGranted) {
    Map<String, String> tags = {
      "title": title,
      "artist": artist,
      "genre": genre,
      "trackNumber": null,
      "trackTotal": null,
      "discNumber": null,
      "discTotal": null,
      "lyrics": null,
      "comment": null,
      "album": album,
      "albumArtist": null,
      "year": null,
      "artwork": null, // Null if obtained from readTags or readTagsAsMap
    };
    await tagger.writeTagsFromMap(path: songFile, tags: tags);
  }
}