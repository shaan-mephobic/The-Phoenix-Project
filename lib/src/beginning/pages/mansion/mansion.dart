import 'dart:io';
import 'package:page_transition/page_transition.dart';
import 'package:phoenix/src/beginning/pages/albums/albums.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/init.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/beginning/pages/albums/albums_inside.dart';
import 'package:phoenix/src/beginning/widgets/artist_collage.dart';
import '../../utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/beginning/pages/artists/artists_inside.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/awakening.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/on_hold.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/page_backend/mansion_back.dart';

var globalMansionConsumer;

class Mansion extends StatefulWidget {
  const Mansion({Key? key}) : super(key: key);

  @override
  _MansionState createState() => _MansionState();
}

class _MansionState extends State<Mansion> with AutomaticKeepAliveClientMixin {
  List<int> albumIndex = [69420, 69421, 69422, 69423, 69424, 69425];
  List<int> artistIndex = [69420, 69421, 69422, 69423, 69424, 69425];
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                ? const BouncingScrollPhysics()
                : const ClampingScrollPhysics(),
            children: [
              Padding(padding: EdgeInsets.only(top: deviceWidth! / 14)),
              // Recently Played
              Container(
                height: deviceWidth! / 1.636,
                width: deviceWidth,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color:
                            Colors.black.withOpacity(glassShadowOpacity! / 100),
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
                            height: deviceWidth! / 9,
                            child: Center(
                              child: Text(
                                "Recently Played",
                                style: TextStyle(
                                    fontSize: deviceWidth! / 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              addAutomaticKeepAlives: true,
                              physics: musicBox.get("fluidAnimation") ?? true
                                  ? const BouncingScrollPhysics()
                                  : const ClampingScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 0, top: 0),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: recentPlayingLengthFoo(),
                              itemBuilder: (BuildContext context, int index) {
                                return Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    height: deviceWidth! / 2,
                                    width: deviceWidth! / 2.5,
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(kRounded),
                                      onTap: () async {
                                        if (recentPlayedMediaItems[index]
                                                .duration ==
                                            const Duration(milliseconds: 0)) {
                                          corruptedFile(context);
                                        } else {
                                          await playThis(
                                              songList
                                                  .indexOf(recentPlayed[index]),
                                              "all");
                                        }
                                      },
                                      onLongPress: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.size,
                                            alignment: Alignment.center,
                                            duration: dialogueAnimationDuration,
                                            reverseDuration:
                                                dialogueAnimationDuration,
                                            child: OnHold(
                                                classContext: context,
                                                listOfSong: recentPlayed,
                                                index: index,
                                                car: orientedCar,
                                                heightOfDevice: deviceHeight,
                                                widthOfDevice: deviceWidth,
                                                songOf: "recent"),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: deviceWidth! / 30)),
                                          PhysicalModel(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(kRounded),
                                            elevation: deviceWidth! / 140,
                                            child: Container(
                                              height: deviceWidth! / 3,
                                              width: deviceWidth! / 3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kRounded),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: MemoryImage(
                                                      artworksData[(musicBox.get(
                                                                  "artworksPointer") ??
                                                              {})[recentPlayed[
                                                                  index]
                                                              .id]] ??
                                                          defaultNone!),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: deviceWidth! / 40)),
                                          Text(
                                            recentPlayed[index].title,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: deviceWidth! / 25,
                                              fontWeight: FontWeight.w600,
                                              shadows: [
                                                Shadow(
                                                  offset: musicBox.get(
                                                              "dynamicArtDB") ??
                                                          true
                                                      ? const Offset(1.0, 1.0)
                                                      : const Offset(0, 1.0),
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
                                );
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
              Padding(padding: EdgeInsets.only(top: deviceWidth! / 7)),
              SizedBox(
                height: deviceWidth! / 1.6,
                width: deviceWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth! / 9,
                      child: Center(
                        child: Text(
                          "Your Favourite",
                          style: TextStyle(
                              fontSize: deviceWidth! / 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: musicBox.get("fluidAnimation") ?? true
                          ? const BouncingScrollPhysics()
                          : const ClampingScrollPhysics(),
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
                                height: deviceWidth! / 2,
                                width: deviceWidth! / 1.6,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(kRounded),
                                  onTap: () async {
                                    if (alwaysPlayedMediaItems[index]
                                            .duration ==
                                        const Duration(milliseconds: 0)) {
                                      corruptedFile(context);
                                    } else {
                                      await playThis(index, "mostly");
                                    }
                                  },
                                  onLongPress: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.size,
                                        alignment: Alignment.center,
                                        duration: dialogueAnimationDuration,
                                        reverseDuration:
                                            dialogueAnimationDuration,
                                        child: OnHold(
                                            classContext: context,
                                            listOfSong: alwaysPlayed,
                                            index: index,
                                            car: orientedCar,
                                            heightOfDevice: deviceHeight,
                                            widthOfDevice: deviceWidth,
                                            songOf: "mostly"),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth! / 30)),
                                      PhysicalModel(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(kRounded),
                                        elevation: deviceWidth! / 140,
                                        child: Container(
                                          height: deviceWidth! / 3,
                                          width: deviceWidth! / 2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(kRounded),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(artworksData[
                                                      (musicBox.get(
                                                              "artworksPointer") ??
                                                          {})[alwaysPlayed[
                                                              index]
                                                          .id]] ??
                                                  defaultNone!),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth! / 40)),
                                      SizedBox(
                                        width: deviceWidth! / 2,
                                        child: Text(
                                          alwaysPlayed[index].title,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: deviceWidth! / 25,
                                            fontWeight: FontWeight.w600,
                                            shadows: [
                                              Shadow(
                                                offset: musicBox.get(
                                                            "dynamicArtDB") ??
                                                        true
                                                    ? const Offset(1.0, 1.0)
                                                    : const Offset(0, 1.0),
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
              Visibility(
                visible: everPlayedLimited.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.only(top: deviceWidth! / 7),
                  child: SizedBox(
                    height: deviceWidth! / 1.6,
                    width: deviceWidth,
                    child: Column(
                      children: [
                        SizedBox(
                          height: deviceWidth! / 9,
                          child: Center(
                            child: Text(
                              "Try Something New",
                              style: TextStyle(
                                  fontSize: deviceWidth! / 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: musicBox.get("fluidAnimation") ?? true
                              ? const BouncingScrollPhysics()
                              : const ClampingScrollPhysics(),
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
                                    height: deviceWidth! / 2,
                                    width: deviceWidth! / 1.6,
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(kRounded),
                                      onTap: () async {
                                        if (everPlayedLimitedMediaItems[index]
                                                .duration ==
                                            const Duration(milliseconds: 0)) {
                                          corruptedFile(context);
                                        } else {
                                          await playThis(index, "never");
                                        }
                                      },
                                      onLongPress: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.size,
                                            alignment: Alignment.center,
                                            duration: dialogueAnimationDuration,
                                            reverseDuration:
                                                dialogueAnimationDuration,
                                            child: OnHold(
                                                classContext: context,
                                                listOfSong: everPlayedLimited,
                                                index: index,
                                                car: orientedCar,
                                                heightOfDevice: deviceHeight,
                                                widthOfDevice: deviceWidth,
                                                songOf: "never"),
                                          ),
                                        );
                                      },
                                      child: Column(children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: deviceWidth! / 30)),
                                        PhysicalModel(
                                          elevation: deviceWidth! / 140,
                                          borderRadius:
                                              BorderRadius.circular(kRounded),
                                          color: Colors.transparent,
                                          child: Container(
                                            height: deviceWidth! / 3,
                                            width: deviceWidth! / 2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRounded),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(artworksData[
                                                        (musicBox.get(
                                                                "artworksPointer") ??
                                                            {})[everPlayedLimited[
                                                                index]
                                                            .id]] ??
                                                    defaultNone!),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: deviceWidth! / 40)),
                                        SizedBox(
                                          width: deviceWidth! / 2,
                                          child: Text(
                                            everPlayedLimited[index].title,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: deviceWidth! / 25,
                                              fontWeight: FontWeight.w600,
                                              shadows: [
                                                Shadow(
                                                  offset: musicBox.get(
                                                              "dynamicArtDB") ??
                                                          true
                                                      ? const Offset(1.0, 1.0)
                                                      : const Offset(0, 1.0),
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
                ),
              ),

              // Artists
              Padding(padding: EdgeInsets.only(top: deviceWidth! / 7)),
              SizedBox(
                height: deviceWidth! / 1.6,
                width: deviceWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth! / 9,
                      child: Center(
                        child: Text(
                          "Favourite Artists",
                          style: TextStyle(
                              fontSize: deviceWidth! / 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: musicBox.get("fluidAnimation") ?? true
                          ? const BouncingScrollPhysics()
                          : const ClampingScrollPhysics(),
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
                                          dominantAlbum!.value,
                                          contrastAlbum!.value
                                        ];
                                        musicBox.put(
                                            "colorsOfArtists", colorMap);
                                      } catch (e) {
                                        contrastAlbum = const Color(0xFF3cb9cd);
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
                                        builder: (context) =>
                                            const ArtistsInside()),
                                  );
                                },
                                child: SizedBox(
                                  height: deviceWidth! / 2,
                                  width: deviceWidth! / 2.5,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth! / 30)),
                                      PhysicalModel(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        elevation: deviceWidth! / 140,
                                        child: Container(
                                          height: deviceWidth! / 3,
                                          width: deviceWidth! / 3,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: artistCollage(
                                              index,
                                              mansionArtists,
                                              deviceWidth! / 1.5,
                                              deviceWidth! / 3),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth! / 40)),
                                      Text(
                                        mansionArtists[index],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: orientedCar
                                              ? deviceHeight! / 54
                                              : deviceWidth! / 30,
                                          fontWeight: FontWeight.w600,
                                          shadows: [
                                            Shadow(
                                              offset: musicBox.get(
                                                          "dynamicArtDB") ??
                                                      true
                                                  ? const Offset(1.0, 1.0)
                                                  : const Offset(0, 1.0),
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
              Padding(padding: EdgeInsets.only(top: deviceWidth! / 7)),
              SizedBox(
                height: deviceWidth! / 1.6,
                width: deviceWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth! / 9,
                      child: Center(
                        child: Text(
                          "Favourite Albums",
                          style: TextStyle(
                            fontSize: deviceWidth! / 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: musicBox.get("fluidAnimation") ?? true
                          ? const BouncingScrollPhysics()
                          : const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int index = 0;
                              index <
                                  (mansionAlbums.length < 6
                                      ? mansionAlbums.length
                                      : 6);
                              index++)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(kRounded),
                                onTap: () async {
                                  passedIndexAlbum = allAlbumsName
                                      .indexOf(mansionAlbums[index].album);
                                  albumIndex[index] = passedIndexAlbum!;
                                  if (musicBox.get("colorsOfAlbums") == null
                                      ? true
                                      : musicBox.get("colorsOfAlbums")[
                                              allAlbums[passedIndexAlbum!]
                                                  .album] ==
                                          null) {
                                    await albumColor(MemoryImage(albumsArts[
                                            allAlbums[passedIndexAlbum!]
                                                .album] ??
                                        defaultNone!));
                                    Map albumColors =
                                        musicBox.get("colorsOfAlbums") ?? {};
                                    albumColors[
                                        allAlbums[passedIndexAlbum!].album] = [
                                      dominantAlbum!.value,
                                      contrastAlbum!.value
                                    ];
                                    musicBox.put("colorsOfAlbums", albumColors);
                                  } else {
                                    dominantAlbum = Color(musicBox
                                            .get("colorsOfAlbums")[
                                        allAlbums[passedIndexAlbum!].album][0]);
                                    contrastAlbum = Color(musicBox
                                            .get("colorsOfAlbums")[
                                        allAlbums[passedIndexAlbum!].album][1]);
                                  }
                                  inAlbumSongs = [];
                                  inAlbumSongsArtIndex = [];
                                  albumMediaItems = [];
                                  await albumSongs();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AlbumsInside()),
                                  );
                                },
                                child: SizedBox(
                                  height: deviceWidth! / 2,
                                  width: deviceWidth! / 2.5,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth! / 30)),
                                      PhysicalModel(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(kRounded),
                                        elevation: deviceWidth! / 140,
                                        child: Container(
                                          height: deviceWidth! / 3,
                                          width: deviceWidth! / 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(kRounded),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(albumsArts[
                                                      mansionAlbums[index]
                                                          .album] ??
                                                  defaultNone!),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceWidth! / 40)),
                                      Text(
                                        mansionAlbums[index]
                                            .album
                                            .toUpperCase(),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: orientedCar
                                              ? deviceHeight! / 54
                                              : deviceWidth! / 30,
                                          fontWeight: FontWeight.w600,
                                          shadows: [
                                            Shadow(
                                              offset: musicBox.get(
                                                          "dynamicArtDB") ??
                                                      true
                                                  ? const Offset(1.0, 1.0)
                                                  : const Offset(0, 1.0),
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
              Padding(padding: EdgeInsets.only(top: deviceWidth! / 7)),
            ],
          ),
        );
      });
    } else {
      return orientedCar
          ? const SingleChildScrollView(child: Awakening())
          : const Awakening();
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
      return 6;
    } else {
      return recentPlayed.length;
    }
  }
}
