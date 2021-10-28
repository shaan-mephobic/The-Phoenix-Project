import 'package:flutter/material.dart';
import 'package:on_audio_edit/on_audio_edit.dart';

Future<bool> editSong(
    {BuildContext context,
    String songFile,
    String title,
    String album,
    String artist,
    String genre}) async {
  Map<TagType, dynamic> tags = {
    TagType.TITLE: title,
    TagType.ARTIST: artist,
    TagType.GENRE: genre,
    TagType.ALBUM: album,
  };
  String permissionPath = await OnAudioEdit().getUri();
  debugPrint(permissionPath);
  debugPrint(await OnAudioEdit().getUri(originalPath: true));
  if (!songFile.contains(permissionPath ?? "")) {
    await OnAudioEdit().resetComplexPermission();
    await OnAudioEdit().requestComplexPermission();
  }
  bool song =
      await OnAudioEdit().editAudio(songFile, tags, searchInsideFolders: true);
  return song;
}
