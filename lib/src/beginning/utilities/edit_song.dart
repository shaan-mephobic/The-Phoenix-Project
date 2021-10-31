import 'package:flutter/material.dart';
import 'package:on_audio_edit/on_audio_edit.dart';

Future<bool> editSong(
    {BuildContext? context,
    required String songFile,
    String? title,
    String? album,
    String? artist,
    String? genre}) async {
  Map<TagType, dynamic> tags = {
    TagType.TITLE: title,
    TagType.ARTIST: artist,
    TagType.GENRE: genre,
    TagType.ALBUM: album,
  };
  await getComplexPermission(songFile);
  bool song =
      await OnAudioEdit().editAudio(songFile, tags, searchInsideFolders: true);
  return song;
}

/// get complex permission
Future<void> getComplexPermission(String song) async {
  final String? permissionPath = await OnAudioEdit().getUri();
  debugPrint(permissionPath);
  debugPrint(await OnAudioEdit().getUri(originalPath: true));

  if (!song.contains(permissionPath ?? "")) {
    await OnAudioEdit().resetComplexPermission();
    await OnAudioEdit().requestComplexPermission();
    await getComplexPermission(song);
  }
}
