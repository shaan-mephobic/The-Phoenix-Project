import 'dart:io';
import 'dart:ui';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/Begin/pages/albums/albums_inside.dart';
import 'package:phoenix/src/Begin/widgets/artist_collage.dart';
import '../../utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/Begin/widgets/list_header.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/on_hold.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import '../../begin.dart';

int artistPassed;
bool artistHero = false;

class ArtistsInside extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }
    return Scaffold(
      body: Theme(
        data: themeOfApp,
        child: Container(
          color: musicBox.get("dynamicArtDB") ?? true
              ? dominantAlbum
              : kMaterialBlack,
          child: CustomScrollView(
            physics: musicBox.get("fluidAnimation") ?? true
                ? BouncingScrollPhysics()
                : ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: musicBox.get("dynamicArtDB") ?? true
                      ? contrastAlbum
                      : Colors.white,
                ),
                expandedHeight: 350,
                backgroundColor: musicBox.get("dynamicArtDB") ?? true
                    ? dominantAlbum
                    : kMaterialBlack,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: EdgeInsets.all(0),
                  background: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 80)),
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRounded),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                // spreadRadius: 1,
                                offset: Offset(0, 2)),
                          ],
                        ),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(kRounded),
                            child: musicBox.get("mapOfArtists") == null
                                ? artistCollage(artistPassed, allArtists,
                                    kRounded, deviceHeight / 4.6)
                                : musicBox.get("mapOfArtists")[
                                            allArtists[artistPassed]] ==
                                        null
                                    ? artistCollage(artistPassed, allArtists,
                                        kRounded, deviceHeight / 4.6)
                                    : Image.file(
                                        File(
                                            "${applicationFileDirectory.path}/artists/${allArtists[artistPassed]}.jpg"),
                                      ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        allArtists[artistPassed].contains(",")
                            ? allArtists[artistPassed]
                                    .replaceRange(
                                        allArtists[artistPassed].indexOf(","),
                                        allArtists[artistPassed].length,
                                        "")
                                    .contains(" FEAT")
                                ? allArtists[artistPassed]
                                    .replaceRange(
                                        allArtists[artistPassed].indexOf(","),
                                        allArtists[artistPassed].length,
                                        "")
                                    .replaceRange(
                                        allArtists[artistPassed]
                                            .indexOf(" FEAT"),
                                        allArtists[artistPassed]
                                            .replaceRange(
                                                allArtists[artistPassed]
                                                    .indexOf(","),
                                                allArtists[artistPassed].length,
                                                "")
                                            .length,
                                        "")
                                : allArtists[artistPassed].replaceRange(
                                    allArtists[artistPassed].indexOf(","),
                                    allArtists[artistPassed].length,
                                    "")
                            : allArtists[artistPassed].contains(" FEAT")
                                ? allArtists[artistPassed].replaceRange(
                                    allArtists[artistPassed].indexOf(" FEAT"),
                                    allArtists[artistPassed].length,
                                    "")
                                : allArtists[artistPassed],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: "Urban",
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 2.2,
                              color: Colors.black26,
                            ),
                          ],
                          fontSize: deviceHeight / 39,
                          color: musicBox.get("dynamicArtDB") ?? true
                              ? contrastAlbum
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == 0) {
                      return ListHeader(deviceWidth, inArtistsSongs, "artist");
                    }
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () async {
                          if (artistMediaItems[index - 1].duration ==
                              Duration(milliseconds: 0)) {
                            corruptedFile(context);
                          } else {
                            insideInArtistsSongs = inArtistsSongs;
                            await playThis(index - 1, "artist");
                          }
                        },
                        onLongPress: () async {
                          Expanded(
                            child: await onHold(
                                context,
                                inArtistsSongs,
                                index - 1,
                                orientedCar,
                                deviceHeight,
                                deviceWidth,
                                "artist"),
                          );
                        },
                        dense: false,
                        // enabled: true,
                        title: Text(
                          inArtistsSongs[index - 1].title,
                          maxLines: 2,
                          style: TextStyle(
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? contrastAlbum
                                : Colors.white,
                            // fontSize: orientedCar
                            //     ? deviceWidth / 28
                            //     : deviceHeight / 60,

                            fontFamily: 'Urban',
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                        tileColor: Colors.transparent,
                        subtitle: Opacity(
                          opacity: 0.5,
                          child: Text(
                            inArtistsSongs[index - 1].artist,
                            maxLines: 1,
                            style: TextStyle(
                              // fontSize: orientedCar
                              //     ? deviceWidth / 41
                              //     : deviceHeight / 73,
                              fontFamily: 'Urban',
                              color: musicBox.get("dynamicArtDB") ?? true
                                  ? contrastAlbum
                                  : Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1.0),
                                  blurRadius: 1.0,
                                  color: Colors.black38,
                                ),
                              ],
                            ),
                          ),
                        ),
                        leading: Card(
                          elevation: 3,
                          color: Colors.transparent,
                          child: ConstrainedBox(
                            constraints: musicBox.get("squareArt") ?? true
                                ? kSqrConstraint
                                : kRectConstraint,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(albumsArts[
                                          inArtistsSongs[index - 1].album] ??
                                      defaultNone),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: numberOfSongsOfArtist + 1,
                  addAutomaticKeepAlives: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  artHeroManager(oink) {
    int toGetIndex;
    for (int woah = 0; woah < allAlbums.length; woah++) {
      if (artistData[allArtists[artistPassed]][oink].albumName ==
          allAlbums[woah].album) {
        toGetIndex = woah;
      }
    }
    return "sterio-$toGetIndex";
  }
}
