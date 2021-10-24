import 'package:flutter/material.dart';
import 'package:on_audio_edit/on_audio_edit.dart';

editSong({songFile, title, album, artist, genre}) async {
  Map<TagType, dynamic> tags = {
    TagType.TITLE: title,
    TagType.ARTIST: artist,
    TagType.GENRE: genre,
    TagType.ALBUM: album,
  };
  bool song =
      await OnAudioEdit().editAudio(songFile, tags, searchInsideFolders: true);
  debugPrint(song.toString());
}
