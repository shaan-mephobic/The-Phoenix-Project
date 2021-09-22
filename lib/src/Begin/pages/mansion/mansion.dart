import 'dart:io';
import 'dart:ui';
import 'package:phoenix/src/Begin/pages/albums/albums.dart';
import 'package:phoenix/src/Begin/utilities/init.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/Begin/pages/albums/albums_inside.dart';
import 'package:phoenix/src/Begin/widgets/artist_collage.dart';
import '../../utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/Begin/pages/artists/artists_inside.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/awakening.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/on_hold.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../begin.dart';
import '../../utilities/page_backend/mansion_back.dart';

var globalMansionConsumer;

class Mansion extends StatefulWidget {
  @override
  _MansionState createState() => _MansionState();
}

class _MansionState extends State<Mansion> with AutomaticKeepAliveClientMixin {
  List<int> albumIndex = [69420, 69421, 69422, 69423, 69424, 69425];
  List<int> artistIndex = [69420, 69421, 69422, 69423, 69424, 69425];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool darkModeOn = true;
    if (ascend) {
      return Consumer<MrMan>(builder: (context, mansionConsumer, child) {
        globalMansionConsumer = mansionConsumer;
        return RefreshIndicator(
          backgroundColor:
              musicBox.get("dynamicArtDB") ?? true ? nowColor : Colors.white,
          color: musicBox.get("dynamicArtDB") ?? true
              ? nowContrast
              : kMaterialBlack,
          onRefresh: () async {
            await fetchAll();
          },
          child: ListView(
            addAutomaticKeepAlives: true,
            physics: musicBox.get("fluidAnimation") ?? true
                ? BouncingScrollPhysics()
                : ClampingScrollPhysics(),
            children: [
              Padding(padding: EdgeInsets.only(top: deviceWidth / 14)),
              // Recently Played
              Container(
                height: deviceWidth / 1.636,
                width: deviceWidth,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color:
                            Colors.black.withOpacity(glassShadowOpacity / 100),
                        blurRadius: glassShadowBlur,
                        offset: kShadowOffset),
                  ],
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: glassBlur,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.04)),
                        color: glassOpacity,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: deviceWidth / 9,
                            child: Center(
                              child: Text(
                                "Recently Played",
                                style: TextStyle(
                                    fontSize: deviceWidth / 15,
                                    fontWeight: FontWeight.w600,
                                    color: musicBox.get("dynamicArtDB") ?? true
                                        ? Colors.white
                                        : darkModeOn
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              addAutomaticKeepAlives: true,
                              physics: musicBox.get("fluidAnimation") ?? true
                                  ? BouncingScrollPhysics()
                                  : ClampingScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 0, top: 0),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: recentPlayingLengthFoo(),
                              itemBuilder: (BuildContext context, int index) {
                                return Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                      height: deviceWidth / 2,
                                      width: deviceWidth / 2.5,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(kRounded),
                                        onTap: () async {
                                          if (recentPlayedMediaItems[index]
                                                  .duration ==
                                              Duration(milliseconds: 0)) {
                                            corruptedFile(context);
                                          } else {
                                            await playThis(
                                                songList.indexOf(
                                                    recentPlayed[index]),
                                                "all");
                                          }
                                        },
                                        onLongPress: () async {
                                          Expanded(
                                            child: await onHold(
                                                context,
                                                recentPlayed,
                                                songList.indexOf(
                                                    recentPlayed[index]),
                                                orientedCar,
                                                deviceHeight,
                                                deviceWidth,
                                                "all"),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: deviceWidth / 30)),
                                            PhysicalModel(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRounded),
                                              elevation: deviceWidth / 140,
                                              child: Container(
                                                height: deviceWidth / 3,
                                                width: deviceWidth / 3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kRounded),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: MemoryImage(
                                                        albumsArts[recentPlayed[
                                                                    index]
                                                                .album] ??
                                                            defaultNone),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: deviceWidth / 40)),
                                            Text(
                                              recentPlayed[index].title,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: musicBox.get(
                                                            "dynamicArtDB") ??
                                                        true
                                                    ? Colors.white
                                                    : darkModeOn
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontSize: deviceWidth / 25,
                                                fontWeight: FontWeight.w600,
                                                shadows: [
                                                  Shadow(
                                                    offset: musicBox.get(
                                                                "dynamicArtDB") ??
                                                            true
                                                        ? Offset(1.0, 1.0)
                                                        : darkModeOn
                                                            ? Offset(0, 1.0)
                                                            : Offset(0, 0.5),
                                                    blurRadius: 2.0,
                                                    color: Colors.black45,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // MOSTLY LISTENED TO
              Padding(padding: EdgeInsets.only(top: deviceWidth / 7)),
              SizedBox(
                height: deviceWidth / 1.6,
                width: deviceWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth / 9,
                      child: Center(
                        child: Text(
                          "Your Favourite",
                          style: TextStyle(
                              fontSize: deviceWidth / 15,
                              fontWeight: FontWeight.w600,
                              color: musicBox.get("dynamicArtDB") ?? true
                                  ? Colors.white
                                  : darkModeOn
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: musicBox.get("fluidAnimation") ?? true
                          ? BouncingScrollPhysics()
                          : ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int index = 0;
                              index <
                                  (alwaysPlayed.length < 6
                                      ? alwaysPlayed.length
                                      : 6);
                              index++)
                            Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                height: deviceWidth / 2,
                                width: deviceWidth / 1.6,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(kRounded),
                                  onTap: () async {
                                    if (alwaysPlayedMediaItems[index]
                                            .duration ==
                                        Duration(milliseconds: 0)) {
                                      corruptedFile(context);
                                    } else {
                                      await playThis(index, "mostly");
                                    }
                                  },
                                  onLongPress: () async {
                                    print(alwaysPlayed[index].title);
                                    Expanded(
                                      child: await onHold(
                                          context,
                                          alwaysPlayed,
                                          index,
                                          orientedCar,
                                          deviceHeight,
                                          deviceWidth,
                                          "mostly"),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth / 30)),
                                      PhysicalModel(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(kRounded),
                                        elevation: deviceWidth / 140,
                                        child: Container(
                                          height: deviceWidth / 3,
                                          width: deviceWidth / 2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(kRounded),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(albumsArts[
                                                          alwaysPlayed[index]
                                                              .album] ??
                                                      defaultNone
                                                  // alwaysPlayedArt[index] ??
                                                  //     defaultNone
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth / 40)),
                                      SizedBox(
                                        width: deviceWidth / 2,
                                        child: Text(
                                          alwaysPlayed[index].title,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                musicBox.get("dynamicArtDB") ??
                                                        true
                                                    ? Colors.white
                                                    : darkModeOn
                                                        ? Colors.white
                                                        : Colors.black,
                                            fontSize: deviceWidth / 25,
                                            fontWeight: FontWeight.w600,
                                            shadows: [
                                              Shadow(
                                                offset: musicBox.get(
                                                            "dynamicArtDB") ??
                                                        true
                                                    ? Offset(1.0, 1.0)
                                                    : darkModeOn
                                                        ? Offset(0, 1.0)
                                                        : Offset(0, 0.5),
                                                blurRadius: 2.0,
                                                color: Colors.black45,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // NEVER LISTENED TO
              Padding(padding: EdgeInsets.only(top: deviceWidth / 7)),
              SizedBox(
                height: deviceWidth / 1.6,
                width: deviceWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth / 9,
                      child: Center(
                        child: Text(
                          "Try Something New",
                          style: TextStyle(
                              fontSize: deviceWidth / 15,
                              fontWeight: FontWeight.w600,
                              color: musicBox.get("dynamicArtDB") ?? true
                                  ? Colors.white
                                  : darkModeOn
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: musicBox.get("fluidAnimation") ?? true
                          ? BouncingScrollPhysics()
                          : ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int index = 0;
                              index <
                                  (everPlayedLimited.length < 6
                                      ? everPlayedLimited.length
                                      : 6);
                              index++)
                            Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                height: deviceWidth / 2,
                                width: deviceWidth / 1.6,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(kRounded),
                                  onTap: () async {
                                    if (everPlayedLimitedMediaItems[index]
                                            .duration ==
                                        Duration(milliseconds: 0)) {
                                      corruptedFile(context);
                                    } else {
                                      await playThis(index, "never");
                                    }
                                  },
                                  onLongPress: () async {
                                    Expanded(
                                      child: await onHold(
                                          context,
                                          everPlayedLimited,
                                          index,
                                          orientedCar,
                                          deviceHeight,
                                          deviceWidth,
                                          "never"),
                                    );
                                  },
                                  child: Column(children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: deviceWidth / 30)),
                                    PhysicalModel(
                                      elevation: deviceWidth / 140,
                                      borderRadius:
                                          BorderRadius.circular(kRounded),
                                      color: Colors.transparent,
                                      child: Container(
                                        height: deviceWidth / 3,
                                        width: deviceWidth / 2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(kRounded),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(albumsArts[
                                                    everPlayedLimited[index]
                                                        .album] ??
                                                defaultNone),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: deviceWidth / 40)),
                                    SizedBox(
                                      width: deviceWidth / 2,
                                      child: Text(
                                        everPlayedLimited[index].title,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: musicBox.get("dynamicArtDB") ??
                                                  true
                                              ? Colors.white
                                              : darkModeOn
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: deviceWidth / 25,
                                          fontWeight: FontWeight.w600,
                                          shadows: [
                                            Shadow(
                                              offset: musicBox.get(
                                                          "dynamicArtDB") ??
                                                      true
                                                  ? Offset(1.0, 1.0)
                                                  : darkModeOn
                                                      ? Offset(0, 1.0)
                                                      : Offset(0, 0.5),
                                              blurRadius: 2.0,
                                              color: Colors.black45,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Artists
              Padding(padding: EdgeInsets.only(top: deviceWidth / 7)),
              SizedBox(
                height: deviceWidth / 1.6,
                width: deviceWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth / 9,
                      child: Center(
                        child: Text(
                          "Favourite Artists",
                          style: TextStyle(
                              fontSize: deviceWidth / 15,
                              fontWeight: FontWeight.w600,
                              color: musicBox.get("dynamicArtDB") ?? true
                                  ? Colors.white
                                  : darkModeOn
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: musicBox.get("fluidAnimation") ?? true
                          ? BouncingScrollPhysics()
                          : ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int index = 0;
                              index <
                                  (mansionArtists.length < 6
                                      ? mansionArtists.length
                                      : 6);
                              index++)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(kRounded),
                                onTap: () async {
                                  inArtistsSongs = [];
                                  artistPassed =
                                      allArtists.indexOf(mansionArtists[index]);
                                  await artistsAllSongs(mansionArtists[index]);
                                  if (musicBox.get("mapOfArtists") != null &&
                                      musicBox.get("mapOfArtists")[
                                              mansionArtists[index]] !=
                                          null) {
                                    if (musicBox.get("colorsOfArtists") == null
                                        ? true
                                        : musicBox.get("colorsOfArtists")[
                                                mansionArtists[index]] ==
                                            null) {
                                      try {
                                        await albumColor(FileImage(File(
                                            "${applicationFileDirectory.path}/artists/${mansionArtists[index]}.jpg")));
                                        Map colorMap =
                                            musicBox.get("colorsOfArtists") ??
                                                {};
                                        colorMap[mansionArtists[index]] = [
                                          dominantAlbum.value,
                                          contrastAlbum.value
                                        ];
                                        musicBox.put(
                                            "colorsOfArtists", colorMap);
                                      } catch (e) {
                                        contrastAlbum = Color(0xFF3cb9cd);
                                        dominantAlbum = kMaterialBlack;
                                      }
                                    } else {
                                      dominantAlbum = Color(
                                          musicBox.get("colorsOfArtists")[
                                              mansionArtists[index]][0]);
                                      contrastAlbum = Color(
                                          musicBox.get("colorsOfArtists")[
                                              mansionArtists[index]][1]);
                                    }
                                  } else {
                                    contrastAlbum = Colors.white;
                                    dominantAlbum = kMaterialBlack;
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArtistsInside()),
                                  );
                                },
                                child: SizedBox(
                                  height: deviceWidth / 2,
                                  width: deviceWidth / 2.5,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth / 30)),
                                      PhysicalModel(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        elevation: deviceWidth / 140,
                                        child: Container(
                                          height: deviceWidth / 3,
                                          width: deviceWidth / 3,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: artistCollage(
                                              index,
                                              mansionArtists,
                                              deviceWidth / 1.5,
                                              deviceWidth / 3),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth / 40)),
                                      Text(
                                        mansionArtists[index],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: musicBox.get("dynamicArtDB") ??
                                                  true
                                              ? Colors.white
                                              : darkModeOn
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: orientedCar
                                              ? deviceHeight / 54
                                              : deviceWidth / 30,
                                          fontWeight: FontWeight.w600,
                                          shadows: [
                                            Shadow(
                                              offset: musicBox.get(
                                                          "dynamicArtDB") ??
                                                      true
                                                  ? Offset(1.0, 1.0)
                                                  : darkModeOn
                                                      ? Offset(0, 1.0)
                                                      : Offset(0, 0.5),
                                              blurRadius: 2.0,
                                              color: Colors.black45,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Albums
              Padding(padding: EdgeInsets.only(top: deviceWidth / 7)),
              SizedBox(
                height: deviceWidth / 1.6,
                width: deviceWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth / 9,
                      child: Center(
                        child: Text(
                          "Favourite Albums",
                          style: TextStyle(
                            fontSize: deviceWidth / 15,
                            fontWeight: FontWeight.w600,
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? Colors.white
                                : darkModeOn
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: musicBox.get("fluidAnimation") ?? true
                          ? BouncingScrollPhysics()
                          : ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int index = 0;
                              index <
                                  (mansionAlbums.length < 6
                                      ? mansionAlbums.length
                                      : 6);
                              index++)
                            Hero(
                              tag: "sterio-${albumIndex[index]}",
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(kRounded),
                                  onTap: () async {
                                    passedIndexAlbum = allAlbumsName.indexOf(
                                        mansionAlbums[index].albumName);
                                    albumIndex[index] = passedIndexAlbum;
                                    if (musicBox.get("colorsOfAlbums") == null
                                        ? true
                                        : musicBox.get("colorsOfAlbums")[
                                                allAlbums[passedIndexAlbum]
                                                    .album] ==
                                            null) {
                                      await albumColor(MemoryImage(albumsArts[
                                              allAlbums[passedIndexAlbum]
                                                  .album] ??
                                          defaultNone));
                                      Map albumColors =
                                          musicBox.get("colorsOfAlbums") ?? {};
                                      albumColors[
                                          allAlbums[passedIndexAlbum].album] = [
                                        dominantAlbum.value,
                                        contrastAlbum.value
                                      ];
                                      musicBox.put(
                                          "colorsOfAlbums", albumColors);
                                    } else {
                                      print("iamspeeeed");
                                      dominantAlbum = Color(musicBox
                                                  .get("colorsOfAlbums")[
                                              allAlbums[passedIndexAlbum].album]
                                          [0]);
                                      contrastAlbum = Color(musicBox
                                                  .get("colorsOfAlbums")[
                                              allAlbums[passedIndexAlbum].album]
                                          [1]);
                                    }
                                    inAlbumSongs = [];
                                    inAlbumSongsArtIndex = [];
                                    albumMediaItems = [];
                                    await albumSongs();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AlbumsInside()),
                                    );
                                  },
                                  child: SizedBox(
                                    height: deviceWidth / 2,
                                    width: deviceWidth / 2.5,
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: deviceWidth / 30)),
                                        PhysicalModel(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(kRounded),
                                          elevation: deviceWidth / 140,
                                          child: Container(
                                            height: deviceWidth / 3,
                                            width: deviceWidth / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRounded),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(albumsArts[
                                                        mansionAlbums[index]
                                                            .albumName] ??
                                                    defaultNone),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: deviceWidth / 40)),
                                        Text(
                                          mansionAlbums[index]
                                              .albumName
                                              .toUpperCase(),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                musicBox.get("dynamicArtDB") ??
                                                        true
                                                    ? Colors.white
                                                    : darkModeOn
                                                        ? Colors.white
                                                        : Colors.black,
                                            fontSize: orientedCar
                                                ? deviceHeight / 54
                                                : deviceWidth / 30,
                                            fontWeight: FontWeight.w600,
                                            shadows: [
                                              Shadow(
                                                offset: musicBox.get(
                                                            "dynamicArtDB") ??
                                                        true
                                                    ? Offset(1.0, 1.0)
                                                    : darkModeOn
                                                        ? Offset(0, 1.0)
                                                        : Offset(0, 0.5),
                                                blurRadius: 2.0,
                                                color: Colors.black45,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: deviceWidth / 7)),
            ],
          ),
        );
      });
    } else {
      return orientedCar
          ? SingleChildScrollView(child: Awakening())
          : Awakening();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

int recentPlayingLengthFoo() {
  if (recentPlayed.isEmpty) {
    return 0;
  } else {
    if (recentPlayed.length >= 6) {
      // print(recentPlayed.length);
      return 6;
    } else {
      // print(recentPlayed.length);
      return recentPlayed.length;
    }
  }
}
