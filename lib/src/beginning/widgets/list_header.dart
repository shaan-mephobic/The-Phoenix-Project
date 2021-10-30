import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import '../utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/beginning/pages/genres/genres_inside.dart';
import 'package:phoenix/src/beginning/pages/playlist/playlist_inside.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';

class ListHeader extends StatelessWidget {
  final double? widthOfDevice;
  final List<SongModel>? listOfSong;
  final String rnAccess;
  const ListHeader(this.widthOfDevice, this.listOfSong, this.rnAccess, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: widthOfDevice,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(glassShadowOpacity! / 100 / 1.4),
            blurRadius: glassShadowBlur / 2,
            offset: kShadowOffset,
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: glassBlur,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.04)),
              color: glassOpacity,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${listOfSong!.length} Tracks",
                    style: const TextStyle(fontSize: 15, color: Colors.white),
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
                              random.nextInt(listOfSong!.length), rnAccess);
                        },
                        icon:
                            const Icon(Ionicons.shuffle_outline, color: Colors.white),
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.white30)),
                        label: const Text(
                          "Shuffle",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
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
                        icon: const Icon(Ionicons.play),
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
