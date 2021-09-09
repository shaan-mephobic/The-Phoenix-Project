import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import '../utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/Begin/pages/genres/genres_inside.dart';
import 'package:phoenix/src/Begin/pages/now_playing/now_playing.dart';
import 'package:phoenix/src/Begin/pages/playlist/playlist_inside.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import '../begin.dart';

class ListHeader extends StatelessWidget {
  final double widthOfDevice;
  final List<SongModel> listOfSong;
  final String rnAccess;
  ListHeader(this.widthOfDevice, this.listOfSong, this.rnAccess);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: widthOfDevice,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.04)),
              color: Colors.white.withOpacity(0.05),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${listOfSong.length} Tracks",
                    style: TextStyle(
                        fontSize: 15, color: Colors.white, fontFamily: "Urban"),
                  ),
                ),
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: TextButton.icon(
                        onPressed: () async {
                          shuffleSelected = true;
                          if (rnAccess == "artist") {
                            insideInArtistsSongs = listOfSong;
                          } else if (rnAccess == "album") {
                            insideInAlbumSongs = listOfSong;
                          } else if (rnAccess == "genre") {
                            insidegenreSongs = listOfSong;
                          } else if (rnAccess == "playlist") {
                            insideplaylistSongsInside = listOfSong;
                          }
                          await playThis(
                              random.nextInt(listOfSong.length), rnAccess);
                        },
                        icon:
                            Icon(Ionicons.shuffle_outline, color: Colors.white),
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.white30)),
                        label: Text(
                          "Shuffle",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Urban"),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () async {
                          if (rnAccess == "artist") {
                            insideInArtistsSongs = listOfSong;
                          } else if (rnAccess == "album") {
                            insideInAlbumSongs = listOfSong;
                          } else if (rnAccess == "genre") {
                            insidegenreSongs = listOfSong;
                          } else if (rnAccess == "playlist") {
                            insideplaylistSongsInside = listOfSong;
                          }
                          await playThis(0, rnAccess);
                        },
                        icon: Icon(Ionicons.play),
                        color: Colors.white,
                        iconSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
