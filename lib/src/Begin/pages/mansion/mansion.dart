import 'dart:io';
import 'dart:ui';
import 'package:phoenix/src/Begin/pages/albums/albums.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/Begin/pages/albums/albums_inside.dart';
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
    // print("the sales gonna rise");
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool darkModeOn = brightness == Brightness.dark;
    bool darkModeOn = true;
    if (ascend) {
      return Consumer<MrMan>(builder: (context, mansionConsumer, child) {
        globalMansionConsumer = mansionConsumer;
        return ListView(
          addAutomaticKeepAlives: true,
          physics: musicBox.get("fluidAnimation")??true
          ? BouncingScrollPhysics() 
          : ClampingScrollPhysics(),
          children: [
            Container(height: deviceWidth / 14),

// Recently Played

            Container(
              // color: Colors.black12,
              height: deviceWidth / 1.636,
              width: deviceWidth,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 13.0,
                      offset: kShadowOffset
                      // spreadRadius: 7,
                      ),
                ],
              ),
              child: ClipRRect(
                // make sure we apply clip it properly
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                      color: Colors.white.withOpacity(0.05),
                    ),
                    // color: Colors.black.withOpacity(0.20),
                    child: Column(
                      children: [
                        Container(
                          height: deviceWidth / 9,
                          child: Center(
                            child: Text(
                              "Recently Played",
                              style: TextStyle(
                                  fontSize: deviceWidth / 15,
                                  fontFamily: "UrbanSB",
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
                            physics: musicBox.get("fluidAnimation")??true
          ? BouncingScrollPhysics() 
          : ClampingScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 0, top: 0),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: recentPlayingLengthFoo(),
                        
                            itemBuilder: (BuildContext context, int index) {
                              // print(index);
                              return Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    height: deviceWidth / 2,
                                    width: deviceWidth / 2.5,
                                    // color: Colors.black12,
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(kRounded),
                                      onTap: () async {
                                        // for (int i = 0;
                                        //     i < songList.length;
                                        //     i++) {
                                        // if (songList[i].data ==
                                        //     recentPlayed[index].data) {
                                        if (recentPlayedMediaItems[index]
                                                .duration ==
                                            Duration(milliseconds: 0)) {
                                          corruptedFile(context);
                                        } else {
                                          await playThis(
                                              songList
                                                  .indexOf(recentPlayed[index]),
                                              "all");
                                        }
                                        // break;
                                        // }
                                        // }
                                      },
                                      onLongPress: () async {
                                        Expanded(
                                          child: await onHold(
                                              context,
                                              recentPlayed,
                                              songList
                                                  .indexOf(recentPlayed[index]),
                                              orientedCar,
                                              deviceHeight,
                                              deviceWidth,
                                              "all"),
                                        );
                                      },
                                      child: Column(children: [
                                        Container(height: deviceWidth / 30),
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
                                                        recentPlayed[index]
                                                            .album] ??
                                                    defaultNone),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(height: deviceWidth / 40),
                                        Text(
                                          recentPlayed[index].title,
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
                                            fontFamily: "UrbanSB",
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
                                      ]),
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
            //     ],
            //   ),
            // ),

// MOSTLY LISTENED TO

            Container(height: deviceWidth / 7),
            Container(
              // color: Colors.black12,
              height: deviceWidth / 1.6,
              width: deviceWidth,
              child: Column(
                children: [
                  Container(
                    height: deviceWidth / 9,
                    child: Center(
                      child: Text(
                        "Your Favourite",
                        style: TextStyle(
                            fontSize: deviceWidth / 15,
                            fontFamily: "UrbanSB",
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? Colors.white
                                : darkModeOn
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: musicBox.get("fluidAnimation")??true
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
                            child: Container(
                              height: deviceWidth / 2,
                              width: deviceWidth / 1.6,
                              // color: Colors.black38,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(kRounded),
                                onTap: () async {
                                  if (alwaysPlayedMediaItems[index].duration ==
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
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(height: deviceWidth / 30),
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
                                      Container(height: deviceWidth / 40),
                                      Container(
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
                                            fontFamily: "UrbanSB",
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

// NEVER LISTENED TO

            Container(height: deviceWidth / 7),
            Container(
              // color: Colors.black12,
              height: deviceWidth / 1.6,
              width: deviceWidth,
              child: Column(
                children: [
                  Container(
                    height: deviceWidth / 9,
                    child: Center(
                      child: Text(
                        "Try Something New",
                        style: TextStyle(
                            fontSize: deviceWidth / 15,
                            fontFamily: "UrbanSB",
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? Colors.white
                                : darkModeOn
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: musicBox.get("fluidAnimation")??true
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
                            child: Container(
                              height: deviceWidth / 2,
                              width: deviceWidth / 1.6,
                              // color: Colors.black38,
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
                                child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(height: deviceWidth / 30),
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
                                                          everPlayedLimited[
                                                                  index]
                                                              .album] ??
                                                      defaultNone
                                                  // everPlayedLimitedArt[index] ??
                                                  //     defaultNone
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(height: deviceWidth / 40),
                                      Container(
                                        width: deviceWidth / 2,
                                        child: Text(
                                          everPlayedLimited[index].title,
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
                                            fontFamily: "UrbanSB",
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

            Container(height: deviceWidth / 7),
            Container(
              // color: Colors.black12,
              height: deviceWidth / 1.6,
              width: deviceWidth,
              child: Column(
                children: [
                  Container(
                    height: deviceWidth / 9,
                    child: Center(
                      child: Text(
                        "Favourite Artists",
                        style: TextStyle(
                            fontSize: deviceWidth / 15,
                            fontFamily: "UrbanSB",
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? Colors.white
                                : darkModeOn
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: musicBox.get("fluidAnimation")??true
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
                                // loop:
                                // for (int i = 0; i < allArtists.length; i++) {
                                //   if (mansionArtists[index] == allArtists[i]) {
                                //     artistPassed = i;
                                //     break loop;
                                //   }
                                // }

                                inArtistsSongs = [];
                                artistPassed =
                                    allArtists.indexOf(mansionArtists[index]);
                                await artistsAllSongs(mansionArtists[index]);
                                if (musicBox.get("mapOfArtists")[
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
                                          musicBox.get("colorsOfArtists") ?? {};
                                      colorMap[mansionArtists[index]] = [
                                        dominantAlbum.value,
                                        contrastAlbum.value
                                      ];
                                      musicBox.put("colorsOfArtists", colorMap);
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
                                  contrastAlbum = Color(0xFF3cb9cd);
                                  dominantAlbum = kMaterialBlack;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ArtistsInside()),
                                );
                              },
                              child: Container(
                                height: deviceWidth / 2,
                                width: deviceWidth / 2.5,
                                // color: Colors.white,
                                child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(height: deviceWidth / 30),
                                      PhysicalModel(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        elevation: deviceWidth / 140,
                                        child: Container(
                                          height: deviceWidth / 3,
                                          width: deviceWidth / 3,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            // image: DecorationImage(
                                            //   fit: BoxFit.contain,
                                            //   image: MemoryImage(defaultNone),
                                            // ),
                                          ),
                                          child: circularArtists(index),
                                        ),
                                      ),
                                      Container(height: deviceWidth / 40),
                                      Container(
                                        // color: Colors.black,
                                        child: Text(
                                          mansionArtists[index],
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
                                            fontFamily: "UrbanSB",
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
                                      ),
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

// Albums

            Container(height: deviceWidth / 7),
            Container(
              // color: Colors.black12,
              height: deviceWidth / 1.6,
              width: deviceWidth,
              child: Column(
                children: [
                  Container(
                    height: deviceWidth / 9,
                    child: Center(
                      child: Text(
                        "Favourite Albums",
                        style: TextStyle(
                          fontSize: deviceWidth / 15,
                          fontFamily: "UrbanSB",
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
                    physics: musicBox.get("fluidAnimation")??true
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
                                  // loop:
                                  // for (int i = 0; i < allAlbums.length; i++) {
                                  //   if (mansionAlbums[index].albumName ==
                                  //       allAlbums[i].albumName) {

                                  passedIndexAlbum = allAlbumsName
                                      .indexOf(mansionAlbums[index].albumName);
                                  albumIndex[index] = passedIndexAlbum;
                                  // albumColor(
                                  //     MemoryImage(albumsArts[
                                  //             allAlbums[passedIndexAlbum]
                                  //                 .albumName] ??
                                  //         defaultNone),
                                  //     true);

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
                                    musicBox.put("colorsOfAlbums", albumColors);
                                  } else {
                                    print("iamspeeeed");
                                    dominantAlbum = Color(musicBox
                                            .get("colorsOfAlbums")[
                                        allAlbums[passedIndexAlbum].album][0]);
                                    contrastAlbum = Color(musicBox
                                            .get("colorsOfAlbums")[
                                        allAlbums[passedIndexAlbum].album][1]);
                                  }
                                  //     break loop;
                                  //   }
                                  // }

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
                                child: Container(
                                  height: deviceWidth / 2,
                                  width: deviceWidth / 2.5,
                                  // color: Colors.white,
                                  child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(height: deviceWidth / 30),
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
                                        Container(height: deviceWidth / 40),
                                        Container(
                                          // color: Colors.black,
                                          child: Text(
                                            mansionAlbums[index]
                                                .albumName
                                                .toUpperCase(),
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
                                              fontSize: orientedCar
                                                  ? deviceHeight / 54
                                                  : deviceWidth / 30,
                                              fontFamily: "UrbanSB",
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
                                        ),
                                      ]),
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

            Container(height: deviceWidth / 7),
          ],
        );
      });
    } else {
      return orientedCar
          ? SingleChildScrollView(child: Awakening())
          : Awakening();
    }
  }

  circularArtists(dat) {
    if (musicBox.get("mapOfArtists") == null
        ? false
        : musicBox.get("mapOfArtists")[mansionArtists[dat]] != null) {
      return Center(
        child: Container(
          width: deviceWidth / 3,
          height: deviceWidth / 3,
          // clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(deviceWidth / 6),
            image: DecorationImage(
              image: FileImage(
                File(
                  "${applicationFileDirectory.path}/artists/${mansionArtists[dat]}.jpg",
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      if (artistsAlbums[mansionArtists[dat]].length == 0) {
        return null;
      } else if (artistsAlbums[mansionArtists[dat]].length == 1) {
        return Center(
          child: Container(
            width: deviceWidth / 3,
            height: deviceWidth / 3,
            // clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(deviceWidth / 6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                    albumsArts[artistsAlbums[mansionArtists[dat]][0]] ??
                        defaultNone),
              ),
            ),
          ),
        );
      } else if (artistsAlbums[mansionArtists[dat]].length == 2) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: deviceWidth / 3,
                height: deviceWidth / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(deviceWidth / 6),
                      topRight: Radius.circular(deviceWidth / 6)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[mansionArtists[dat]][0]] ??
                            defaultNone),
                  ),
                ),
              ),
              Container(
                width: deviceWidth / 3,
                height: deviceWidth / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(deviceWidth / 6),
                      bottomRight: Radius.circular(deviceWidth / 6)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[mansionArtists[dat]][1]] ??
                            defaultNone),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (artistsAlbums[mansionArtists[dat]].length == 3) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: deviceWidth / 6,
                    height: deviceWidth / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(deviceWidth / 6),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            albumsArts[artistsAlbums[mansionArtists[dat]][0]] ??
                                defaultNone),
                      ),
                    ),
                  ),
                  Container(
                    width: deviceWidth / 6,
                    height: deviceWidth / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(deviceWidth / 6),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            albumsArts[artistsAlbums[mansionArtists[dat]][1]] ??
                                defaultNone),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: deviceWidth / 3,
                height: deviceWidth / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(deviceWidth / 6),
                    bottomLeft: Radius.circular(deviceWidth / 6),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                        albumsArts[artistsAlbums[mansionArtists[dat]][2]] ??
                            defaultNone),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: deviceWidth / 6,
                    height: deviceWidth / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(deviceWidth / 6),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            albumsArts[artistsAlbums[mansionArtists[dat]][0]] ??
                                defaultNone),
                      ),
                    ),
                  ),
                  Container(
                    width: deviceWidth / 6,
                    height: deviceWidth / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(deviceWidth / 6),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            albumsArts[artistsAlbums[mansionArtists[dat]][1]] ??
                                defaultNone),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: deviceWidth / 6,
                    height: deviceWidth / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(deviceWidth / 6),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            albumsArts[artistsAlbums[mansionArtists[dat]][2]] ??
                                defaultNone),
                      ),
                    ),
                  ),
                  Container(
                    width: deviceWidth / 6,
                    height: deviceWidth / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(deviceWidth / 6),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            albumsArts[artistsAlbums[mansionArtists[dat]][3]] ??
                                defaultNone),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
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

