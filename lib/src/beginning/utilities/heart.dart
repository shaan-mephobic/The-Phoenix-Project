import 'package:phoenix/src/beginning/utilities/global_variables.dart';

void addToLikedSong(data) async {
  Map check = musicBox.get('playlists') ?? {};
  List<String> likedSongs = check["Liked Songs"] ?? [];
  likedSongs.add(data);
  check['Liked Songs'] = likedSongs;
  musicBox.put('playlists', check);
}

void rmLikedSong(data) async {
  Map check = musicBox.get('playlists') ?? {};
  List<String> likedSongs = check["Liked Songs"];
  likedSongs.remove(data);
  check['Liked Songs'] = likedSongs;
  musicBox.put('playlists', check);
}

bool isSongLiked(data) {
  Map check = musicBox.get('playlists') ?? {};
  if ((check.keys.toList().contains("Liked Songs")) &&
      (check["Liked Songs"].contains(data))) {
    return false;
  } else {
    return true;
  }
}
