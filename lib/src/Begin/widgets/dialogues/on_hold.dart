import 'dart:io';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phoenix/src/begin/utilities/global_variables.dart';
import 'package:phoenix/src/begin/utilities/heart.dart';
import 'package:phoenix/src/begin/utilities/native/go_native.dart';
import 'package:phoenix/src/begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/begin/pages/ringtone/ringtone.dart';
import '../../utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/begin/pages/genres/genres.dart';
import 'package:phoenix/src/begin/pages/genres/genres_inside.dart';
import '../../utilities/page_backend/mansion_back.dart';
import 'package:phoenix/src/begin/pages/playlist/playlist_inside.dart';
import 'package:phoenix/src/begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/begin/utilities/screenshot_UI.dart';
import 'package:share_plus/share_plus.dart';
import '../../utilities/constants.dart';
import '../../utilities/edit_song.dart';
import 'r_support.dart';

var tagger;

Future<Widget> onHold(
    BuildContext classContext,
    List<SongModel> listOfSong,
    int index,
    bool car,
    double heightOfDevice,
    double widthOfDevice,
    String songOf) async {
  List songMoreInfo = [
    "Play Now",
    "Add To Queue",
    "Add To PlayList",
    "Share",
    "Set Ringtone",
    "Edit",
    "Delete"
  ];
  return await showDialog(
    context: classContext,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                      ),
                      alignment: Alignment.center,
                      width: car ? heightOfDevice / 2 : widthOfDevice / 1.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kRounded),
                        child: BackdropFilter(
                          filter: glassBlur,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kRounded),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.04)),
                              color: glassOpacity,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListView(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: car
                                              ? widthOfDevice / 12
                                              : heightOfDevice / 25),
                                    ),
                                    for (int i = 0;
                                        i < songMoreInfo.length;
                                        i++)
                                      Material(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Container(
                                            // color: Colors.black38,
                                            width: car
                                                ? heightOfDevice
                                                : widthOfDevice,
                                            height: car
                                                ? widthOfDevice / 6
                                                : heightOfDevice / 12.5,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () async {
                                                  if (i == 0) {
                                                    if (songOf == "album") {
                                                      // insideInAlbumSongs = [];
                                                      insideInAlbumSongs =
                                                          inAlbumSongs;
                                                    }
                                                    if (songOf == "artist") {
                                                      // insideInArtistsSongs = [];
                                                      insideInArtistsSongs =
                                                          inArtistsSongs;
                                                    }
                                                    if (songOf == "genre") {
                                                      // insidegenreSongs = [];
                                                      insidegenreSongs =
                                                          genreSongs;
                                                    }
                                                    await playThis(
                                                        index, songOf);
                                                    Navigator.pop(context);
                                                  } else if (i == 1) {
                                                    if (songOf == "all") {
                                                      addToQueue(
                                                          songListMediaItems[
                                                              index]);
                                                    } else if (songOf ==
                                                        "album") {
                                                      addToQueue(
                                                          albumMediaItems[
                                                              index]);
                                                    } else if (songOf ==
                                                        "artist") {
                                                      addToQueue(
                                                          artistMediaItems[
                                                              index]);
                                                    } else if (songOf ==
                                                        "genre") {
                                                      addToQueue(
                                                          genreMediaItems[
                                                              index]);
                                                    } else if (songOf ==
                                                        "recent") {
                                                      addToQueue(
                                                          recentPlayedMediaItems[
                                                              index]);
                                                    } else if (songOf ==
                                                        "mostly") {
                                                      addToQueue(
                                                          alwaysPlayedMediaItems[
                                                              index]);
                                                    } else if (songOf ==
                                                        "never") {
                                                      addToQueue(
                                                          everPlayedLimitedMediaItems[
                                                              index]);
                                                    } else if (songOf ==
                                                        "playlist") {
                                                      addToQueue(
                                                          playlistMediaItems[
                                                              index]);
                                                    }

                                                    Navigator.pop(context);
                                                  } else if (i == 2) {
                                                    Map check = musicBox
                                                            .get('playlists') ??
                                                        {};
                                                    if (check.keys
                                                        .toList()
                                                        .isEmpty) {
                                                      Flushbar(
                                                        messageText: Text(
                                                            "Create A Playlist First.",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Futura",
                                                                color: Colors
                                                                    .white)),
                                                        icon: Icon(
                                                          Icons
                                                              .error_outline_rounded,
                                                          size: 28.0,
                                                          color:
                                                              Color(0xFFCB0447),
                                                        ),
                                                        shouldIconPulse: true,
                                                        dismissDirection:
                                                            FlushbarDismissDirection
                                                                .HORIZONTAL,
                                                        duration: Duration(
                                                            seconds: 5),
                                                        borderColor: Colors
                                                            .white
                                                            .withOpacity(0.04),
                                                        borderWidth: 1,
                                                        backgroundColor:
                                                            glassOpacity,
                                                        flushbarStyle:
                                                            FlushbarStyle
                                                                .FLOATING,
                                                        isDismissible: true,
                                                        barBlur: musicBox.get(
                                                                    "glassBlur") ==
                                                                null
                                                            ? 18
                                                            : musicBox.get(
                                                                "glassBlur"),
                                                        margin: EdgeInsets.only(
                                                            bottom: 20,
                                                            left: 8,
                                                            right: 8),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        // leftBarIndicatorColor:
                                                        //     Color(0xFFCB0047),
                                                      )..show(context);
                                                    } else {
                                                      Navigator.pop(context);
                                                      Expanded(
                                                        child: await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                              builder: (context,
                                                                  StateSetter
                                                                      setState) {
                                                                return Center(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    physics:
                                                                        BouncingScrollPhysics(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              0,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(kRounded),
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            width: car
                                                                                ? heightOfDevice / 2
                                                                                : widthOfDevice / 1.2,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(kRounded),
                                                                              child: BackdropFilter(
                                                                                filter: glassBlur,
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(kRounded),
                                                                                    border: Border.all(color: Colors.white.withOpacity(0.04)),
                                                                                    color: glassOpacity,
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      ListView(
                                                                                        physics: BouncingScrollPhysics(),
                                                                                        shrinkWrap: true,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(top: car ? widthOfDevice / 12 : heightOfDevice / 25),
                                                                                          ),
                                                                                          for (int o = 0; o < check.keys.toList().length; o++)
                                                                                            Material(
                                                                                              color: Colors.transparent,
                                                                                              child: Center(
                                                                                                child: SizedBox(
                                                                                                  width: car ? heightOfDevice : widthOfDevice,
                                                                                                  height: car ? widthOfDevice / 6 : heightOfDevice / 12.5,
                                                                                                  child: Material(
                                                                                                    color: Colors.transparent,
                                                                                                    child: InkWell(
                                                                                                      onTap: () {
                                                                                                        Navigator.pop(context);
                                                                                                        if (check[check.keys.toList()[o]].contains(listOfSong[index].data)) {
                                                                                                          Flushbar(
                                                                                                            messageText: Text("Song Already In Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                            icon: Icon(
                                                                                                              Icons.error_outline_rounded,
                                                                                                              size: 28.0,
                                                                                                              color: Color(0xFFCB0447),
                                                                                                            ),
                                                                                                            shouldIconPulse: true,
                                                                                                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                            duration: Duration(seconds: 5),
                                                                                                            borderColor: Colors.white.withOpacity(0.04),
                                                                                                            borderWidth: 1,
                                                                                                            backgroundColor: glassOpacity,
                                                                                                            flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                            isDismissible: true,
                                                                                                            barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                            margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                            borderRadius: BorderRadius.circular(15),
                                                                                                          )..show(context);
                                                                                                        } else {
                                                                                                          check[check.keys.toList()[o]].add(listOfSong[index].data);
                                                                                                          musicBox.put("playlists", check);
                                                                                                          Flushbar(
                                                                                                            messageText: Text("Song Added To Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                            icon: Icon(
                                                                                                              Icons.add,
                                                                                                              size: 28.0,
                                                                                                              color: kCorrect,
                                                                                                            ),
                                                                                                            shouldIconPulse: true,
                                                                                                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                            duration: Duration(seconds: 5),
                                                                                                            borderColor: Colors.white.withOpacity(0.04),
                                                                                                            borderWidth: 1,
                                                                                                            backgroundColor: glassOpacity,
                                                                                                            flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                            isDismissible: true,
                                                                                                            barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                            margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                            borderRadius: BorderRadius.circular(15),
                                                                                                          )..show(context);
                                                                                                        }
                                                                                                      },
                                                                                                      child: Center(
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.only(left: 12),
                                                                                                          child: Text(
                                                                                                            check.keys.toList()[o],
                                                                                                            maxLines: 2,
                                                                                                            style: TextStyle(
                                                                                                              color: musicBox.get("dynamicArtDB") ?? true ? Colors.white70 : Colors.white70,
                                                                                                              fontSize: car ? widthOfDevice / 26 : heightOfDevice / 56,
                                                                                                              shadows: [
                                                                                                                Shadow(
                                                                                                                  offset: musicBox.get("dynamicArtDB") ?? true ? Offset(0, 1.0) : Offset(0, 1.0),
                                                                                                                  blurRadius: musicBox.get("dynamicArtDB") ?? true ? 3.0 : 3.0,
                                                                                                                  color: Colors.black54,
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(top: car ? widthOfDevice / 12 : heightOfDevice / 25),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  } else if (i == 3) {
                                                    await Share.shareFiles(
                                                      [listOfSong[index].data],
                                                    );
                                                  } else if (i == 4) {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => Ringtone(
                                                            artworkId:
                                                                listOfSong[
                                                                        index]
                                                                    .id,
                                                            filePath:
                                                                listOfSong[
                                                                        index]
                                                                    .data,
                                                            artist: listOfSong[
                                                                    index]
                                                                .artist,
                                                            title: listOfSong[
                                                                    index]
                                                                .title,
                                                            songDuration:
                                                                listOfSong[index]
                                                                        .duration *
                                                                    1.0),
                                                      ),
                                                    );
                                                  }

                                                  /// Edit Song
                                                  else if (i == 5) {
                                                    if (isAndroid11) {
                                                      androidRSupport(context);
                                                    } else {
                                                      Navigator.pop(context);
                                                      try {
                                                        final tag = await tagger
                                                            .readTags(
                                                                path: listOfSong[
                                                                        index]
                                                                    .data);
                                                        var titleOfSong =
                                                            tag.title;
                                                        var artistOfSong =
                                                            tag.artist;
                                                        var genreOfSong =
                                                            tag.genre;
                                                        var albumOfSong =
                                                            tag.album;

                                                        bool shouldEdit = false;

                                                        Expanded(
                                                          child:
                                                              await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return StatefulBuilder(
                                                                builder: (context,
                                                                    StateSetter
                                                                        setState) {
                                                                  return Center(
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                0,
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                              ),
                                                                              alignment: Alignment.center,
                                                                              width: car ? heightOfDevice / 2 : widthOfDevice / 1.2,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                                child: BackdropFilter(
                                                                                  filter: glassBlur,
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(kRounded),
                                                                                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                                                                                      color: glassOpacity,
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Padding(padding: EdgeInsets.only(top: car ? widthOfDevice / 16 : heightOfDevice / 40)),
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = titleOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                titleOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "TITLE",
                                                                                                  hintText: "",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: car ? widthOfDevice / 8 : heightOfDevice / 20)),

                                                                                        ///ALBUM
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Container(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.transparent,
                                                                                            ),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = albumOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                albumOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "ALBUM",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  hintText: "",
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: car ? widthOfDevice / 8 : heightOfDevice / 20)),

                                                                                        ///Artist
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = artistOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                artistOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "ARTIST",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  hintText: "",
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: car ? widthOfDevice / 8 : heightOfDevice / 20)),

                                                                                        ///Genre
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = genreOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                genreOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "GENRE",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  hintText: "",
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: car ? widthOfDevice / 8 : heightOfDevice / 20)),
                                                                                        Padding(padding: EdgeInsets.only(top: car ? widthOfDevice / 8 : heightOfDevice / 20)),
                                                                                        Material(
                                                                                          borderRadius: BorderRadius.circular(kRounded),
                                                                                          color: Colors.transparent,
                                                                                          child: InkWell(
                                                                                            borderRadius: BorderRadius.circular(kRounded),
                                                                                            onTap: () async {
                                                                                              if (shouldEdit) {
                                                                                                Navigator.pop(context);
                                                                                                await editSong(listOfSong[index].data, titleOfSong, albumOfSong, artistOfSong, genreOfSong);
                                                                                                refresh = true;
                                                                                                await Future.delayed(Duration(seconds: 1));
                                                                                                rootState.provideman();
                                                                                              }
                                                                                            },
                                                                                            child: Container(
                                                                                              height: widthOfDevice / 12,
                                                                                              width: widthOfDevice / 4,
                                                                                              decoration: BoxDecoration(
                                                                                                boxShadow: [
                                                                                                  BoxShadow(
                                                                                                    color: Colors.black12,
                                                                                                    blurRadius: 1.0,
                                                                                                    spreadRadius: widthOfDevice / 220,
                                                                                                  ),
                                                                                                ],
                                                                                                color: Color(0xFF1DB954),
                                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Text("DONE", textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontSize: widthOfDevice / 25, fontWeight: FontWeight.w600)),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: car ? widthOfDevice / 16 : heightOfDevice / 40)),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      } catch (e) {
                                                        Flushbar(
                                                          message:
                                                              "The File Might be Unsupported/Corrupted.",
                                                          icon: Icon(
                                                            Icons.info_outline,
                                                            size: 28.0,
                                                            color: Color(
                                                                0xFFCB0447),
                                                          ),
                                                          shouldIconPulse: true,
                                                          borderColor: Colors
                                                              .white
                                                              .withOpacity(
                                                                  0.04),
                                                          borderWidth: 1,
                                                          backgroundColor:
                                                              glassOpacity,
                                                          flushbarStyle:
                                                              FlushbarStyle
                                                                  .FLOATING,
                                                          isDismissible: true,
                                                          barBlur: musicBox.get(
                                                                      "glassBlur") ==
                                                                  null
                                                              ? 18
                                                              : musicBox.get(
                                                                  "glassBlur"),
                                                          dismissDirection:
                                                              FlushbarDismissDirection
                                                                  .HORIZONTAL,
                                                          duration: Duration(
                                                              seconds: 5),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20,
                                                                  left: 8,
                                                                  right: 8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        )..show(context);
                                                      }
                                                    }
                                                  } else if (i == 6) {
                                                    if (isAndroid11) {
                                                      androidRSupport(context);
                                                    } else {
                                                      if (await Permission
                                                          .storage
                                                          .request()
                                                          .isGranted) {
                                                        await deleteAFile(
                                                            listOfSong[index]
                                                                .data);
                                                        Navigator.pop(context);
                                                        await Future.delayed(
                                                            Duration(
                                                                seconds: 2));

                                                        refresh = true;
                                                        rootState.provideman();
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12),
                                                    child: Text(
                                                      songMoreInfo[i],
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: musicBox.get(
                                                                    "dynamicArtDB") ??
                                                                true
                                                            ? Colors.white70
                                                            : Colors.white70,
                                                        fontSize: car
                                                            ? widthOfDevice / 26
                                                            : heightOfDevice /
                                                                56,
                                                        shadows: [
                                                          Shadow(
                                                            offset: musicBox.get(
                                                                        "dynamicArtDB") ??
                                                                    true
                                                                ? Offset(0, 1.0)
                                                                : Offset(
                                                                    0, 1.0),
                                                            blurRadius: 3.0,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: car
                                          ? widthOfDevice / 12
                                          : heightOfDevice / 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<Widget> onHoldExtended(
  BuildContext context,
  bool car,
  double heightOfDevice,
  double widthOfDevice,
) async {
  List songMoreInfoNP = [
    "Share Now Playing",
    "Add To Liked Songs",
    "Add To PlayList",
    "Share File",
    "Edit File",
    "Set Ringtone",
    "Save Wallpaper",
    "Set As Home Screen",
    "Delete"
  ];
  bool darkModeOn = true;
  return Expanded(
    child: await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRounded),
                        ),
                        alignment: Alignment.center,
                        width: car ? heightOfDevice / 2 : widthOfDevice / 1.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kRounded),
                          child: BackdropFilter(
                            filter: glassBlur,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kRounded),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.04)),
                                color: glassOpacity,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListView(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: car
                                                ? widthOfDevice / 12
                                                : heightOfDevice / 25),
                                      ),
                                      for (int i = 0;
                                          i < songMoreInfoNP.length;
                                          i++)
                                        Material(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: SizedBox(
                                              width: car
                                                  ? heightOfDevice
                                                  : widthOfDevice,
                                              height: car
                                                  ? widthOfDevice / 6
                                                  : heightOfDevice / 12.5,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (i == 0) {
                                                      // Share Now Playing
                                                      await screenShotUI(false);
                                                      Directory appDocDir =
                                                          await getExternalStorageDirectory();
                                                      String appDocPath =
                                                          appDocDir.path;
                                                      await Share.shareFiles(
                                                        [
                                                          '$appDocPath/legendary-er.png'
                                                        ],
                                                      );
                                                    } else if (i == 1) {
                                                      // Add to Liked Songs
                                                      if (!isSongLiked(
                                                          nowMediaItem.id)) {
                                                        rmLikedSong(
                                                            nowMediaItem.id);

                                                        Navigator.pop(context);
                                                        Flushbar(
                                                          messageText: Text(
                                                              "Removed From Liked Songs",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Futura",
                                                                  color: Colors
                                                                      .white)),
                                                          icon: Icon(
                                                            Icons.block_rounded,
                                                            size: 28.0,
                                                            color: Color(
                                                                0xFFCB0447),
                                                          ),
                                                          shouldIconPulse: true,
                                                          dismissDirection:
                                                              FlushbarDismissDirection
                                                                  .HORIZONTAL,
                                                          duration: Duration(
                                                              seconds: 5),
                                                          borderColor: Colors
                                                              .white
                                                              .withOpacity(
                                                                  0.04),
                                                          borderWidth: 1,
                                                          backgroundColor:
                                                              glassOpacity,
                                                          flushbarStyle:
                                                              FlushbarStyle
                                                                  .FLOATING,
                                                          isDismissible: true,
                                                          barBlur: musicBox.get(
                                                                      "glassBlur") ==
                                                                  null
                                                              ? 18
                                                              : musicBox.get(
                                                                  "glassBlur"),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20,
                                                                  left: 8,
                                                                  right: 8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        )..show(context);
                                                      } else {
                                                        addToLikedSong(
                                                            nowMediaItem.id);

                                                        Navigator.pop(context);
                                                        Flushbar(
                                                          messageText: Text(
                                                              "Added To Liked Songs",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Futura",
                                                                  color: Colors
                                                                      .white)),
                                                          icon: Icon(
                                                            MdiIcons.heart,
                                                            size: 28.0,
                                                            color: Color(
                                                                0xFFCB0447),
                                                          ),
                                                          shouldIconPulse: true,
                                                          dismissDirection:
                                                              FlushbarDismissDirection
                                                                  .HORIZONTAL,
                                                          duration: Duration(
                                                              seconds: 5),
                                                          borderColor: Colors
                                                              .white
                                                              .withOpacity(
                                                                  0.04),
                                                          borderWidth: 1,
                                                          backgroundColor:
                                                              glassOpacity,
                                                          flushbarStyle:
                                                              FlushbarStyle
                                                                  .FLOATING,
                                                          isDismissible: true,
                                                          barBlur: musicBox.get(
                                                                      "glassBlur") ==
                                                                  null
                                                              ? 18
                                                              : musicBox.get(
                                                                  "glassBlur"),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20,
                                                                  left: 8,
                                                                  right: 8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        )..show(context);
                                                      }
                                                    } else if (i == 2) {
                                                      // add to playlist
                                                      Map check = musicBox.get(
                                                              'playlists') ??
                                                          {};
                                                      if (check.keys
                                                          .toList()
                                                          .isEmpty) {
                                                        Flushbar(
                                                          messageText: Text(
                                                              "Create A Playlist First.",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Futura",
                                                                  color: Colors
                                                                      .white)),
                                                          icon: Icon(
                                                            Icons
                                                                .error_outline_rounded,
                                                            size: 28.0,
                                                            color: Color(
                                                                0xFFCB0447),
                                                          ),
                                                          shouldIconPulse: true,
                                                          dismissDirection:
                                                              FlushbarDismissDirection
                                                                  .HORIZONTAL,
                                                          duration: Duration(
                                                              seconds: 5),
                                                          borderColor: Colors
                                                              .white
                                                              .withOpacity(
                                                                  0.04),
                                                          borderWidth: 1,
                                                          backgroundColor:
                                                              glassOpacity,
                                                          flushbarStyle:
                                                              FlushbarStyle
                                                                  .FLOATING,
                                                          isDismissible: true,
                                                          barBlur: musicBox.get(
                                                                      "glassBlur") ==
                                                                  null
                                                              ? 18
                                                              : musicBox.get(
                                                                  "glassBlur"),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20,
                                                                  left: 8,
                                                                  right: 8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        )..show(context);
                                                      } else {
                                                        Navigator.pop(context);
                                                        Expanded(
                                                          child:
                                                              await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return StatefulBuilder(
                                                                builder: (context,
                                                                    StateSetter
                                                                        setState) {
                                                                  return Center(
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                0,
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                              ),
                                                                              alignment: Alignment.center,
                                                                              width: car ? heightOfDevice / 2 : widthOfDevice / 1.2,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                                child: BackdropFilter(
                                                                                  filter: glassBlur,
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(kRounded),
                                                                                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                                                                                      color: glassOpacity,
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        ListView(
                                                                                          physics: BouncingScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsets.only(top: car ? widthOfDevice / 12 : heightOfDevice / 25),
                                                                                            ),
                                                                                            for (int o = 0; o < check.keys.toList().length; o++)
                                                                                              Material(
                                                                                                color: Colors.transparent,
                                                                                                child: Center(
                                                                                                  child: SizedBox(
                                                                                                    width: car ? heightOfDevice : widthOfDevice,
                                                                                                    height: car ? widthOfDevice / 6 : heightOfDevice / 12.5,
                                                                                                    child: Material(
                                                                                                      color: Colors.transparent,
                                                                                                      child: InkWell(
                                                                                                        onTap: () {
                                                                                                          Navigator.pop(context);
                                                                                                          if (check[check.keys.toList()[o]].contains(nowMediaItem.id)) {
                                                                                                            Flushbar(
                                                                                                              messageText: Text("Song Already In Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                              icon: Icon(
                                                                                                                Icons.error_outline_rounded,
                                                                                                                size: 28.0,
                                                                                                                color: Color(0xFFCB0447),
                                                                                                              ),
                                                                                                              shouldIconPulse: true,
                                                                                                              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                              duration: Duration(seconds: 5),
                                                                                                              borderColor: Colors.white.withOpacity(0.04),
                                                                                                              borderWidth: 1,
                                                                                                              backgroundColor: glassOpacity,
                                                                                                              flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                              isDismissible: true,
                                                                                                              barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                              margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                              borderRadius: BorderRadius.circular(15),
                                                                                                            )..show(context);
                                                                                                          } else {
                                                                                                            check[check.keys.toList()[o]].add(nowMediaItem.id);
                                                                                                            musicBox.put("playlists", check);
                                                                                                            Flushbar(
                                                                                                              messageText: Text("Song Added To Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                              icon: Icon(
                                                                                                                Icons.add,
                                                                                                                size: 28.0,
                                                                                                                color: kCorrect,
                                                                                                              ),
                                                                                                              shouldIconPulse: true,
                                                                                                              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                              duration: Duration(seconds: 5),
                                                                                                              borderColor: Colors.white.withOpacity(0.04),
                                                                                                              borderWidth: 1,
                                                                                                              backgroundColor: glassOpacity,
                                                                                                              flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                              isDismissible: true,
                                                                                                              barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                              margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                              borderRadius: BorderRadius.circular(15),
                                                                                                            )..show(context);
                                                                                                          }
                                                                                                        },
                                                                                                        child: Center(
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.only(left: 12),
                                                                                                            child: Text(
                                                                                                              check.keys.toList()[o],
                                                                                                              maxLines: 2,
                                                                                                              style: TextStyle(
                                                                                                                color: musicBox.get("dynamicArtDB") ?? true
                                                                                                                    ? Colors.white70
                                                                                                                    : darkModeOn
                                                                                                                        ? Colors.white70
                                                                                                                        : Colors.black87,
                                                                                                                fontSize: car ? widthOfDevice / 26 : heightOfDevice / 56,
                                                                                                                shadows: [
                                                                                                                  Shadow(
                                                                                                                    offset: musicBox.get("dynamicArtDB") ?? true
                                                                                                                        ? Offset(0, 1.0)
                                                                                                                        : darkModeOn
                                                                                                                            ? Offset(0, 1.0)
                                                                                                                            : Offset(0, 0.5),
                                                                                                                    blurRadius: musicBox.get("dynamicArtDB") ?? true
                                                                                                                        ? 3.0
                                                                                                                        : darkModeOn
                                                                                                                            ? 3.0
                                                                                                                            : 2.0,
                                                                                                                    color: darkModeOn ? Colors.black54 : Colors.black38,
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.only(top: car ? widthOfDevice / 12 : heightOfDevice / 25),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }
                                                    } else if (i == 3) {
                                                      await Share.shareFiles(
                                                        [nowMediaItem.id],
                                                      );
                                                    }

                                                    /// Edit Song
                                                    else if (i == 4) {
                                                      if (isAndroid11) {
                                                        androidRSupport(
                                                            context);
                                                      } else {
                                                        Navigator.pop(context);
                                                        try {
                                                          final tag = await tagger
                                                              .readTags(
                                                                  path:
                                                                      nowMediaItem
                                                                          .id);
                                                          bool shouldEdit =
                                                              false;
                                                          var titleOfSong =
                                                              tag.title;
                                                          var artistOfSong =
                                                              tag.artist;
                                                          var genreOfSong =
                                                              tag.genre;
                                                          var albumOfSong =
                                                              tag.album;
                                                          Expanded(
                                                              child:
                                                                  await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return StatefulBuilder(
                                                                builder: (context,
                                                                    StateSetter
                                                                        setState) {
                                                                  return Center(
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                0,
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                              ),
                                                                              alignment: Alignment.center,
                                                                              width: car ? heightOfDevice / 2 : widthOfDevice / 1.2,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                                child: BackdropFilter(
                                                                                  filter: glassBlur,
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(kRounded),
                                                                                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                                                                                      color: glassOpacity,
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Padding(padding: EdgeInsets.only(top: orientedCar ? widthOfDevice / 16 : heightOfDevice / 40)),
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = titleOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                titleOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "TITLE",
                                                                                                  hintText: "",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: orientedCar ? widthOfDevice / 8 : heightOfDevice / 20)),

                                                                                        ///ALBUM
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = albumOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                albumOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "ALBUM",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  hintText: "",
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: orientedCar ? widthOfDevice / 8 : heightOfDevice / 20)),

                                                                                        ///Artist
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = artistOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                artistOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "ARTIST",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  hintText: "",
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: orientedCar ? widthOfDevice / 8 : heightOfDevice / 20)),

                                                                                        ///Genre
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                                                                            child: TextField(
                                                                                              cursorColor: Color(0xFF3cb9cd),
                                                                                              autofocus: false,
                                                                                              controller: TextEditingController()..text = genreOfSong,
                                                                                              style: TextStyle(color: Colors.white, fontFamily: "Futura"),
                                                                                              onChanged: (text) {
                                                                                                shouldEdit = true;
                                                                                                genreOfSong = text;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderRadius: const BorderRadius.all(
                                                                                                      Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                                    borderSide: BorderSide(color: Color(0xFF3cb9cd)),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                                                                                  labelText: "GENRE",
                                                                                                  labelStyle: TextStyle(color: Colors.grey[350], fontFamily: "Futura"),
                                                                                                  hintText: "",
                                                                                                  fillColor: Colors.transparent),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: orientedCar ? widthOfDevice / 8 : heightOfDevice / 20)),

                                                                                        Padding(padding: EdgeInsets.only(top: orientedCar ? widthOfDevice / 8 : heightOfDevice / 20)),
                                                                                        Material(
                                                                                          borderRadius: BorderRadius.circular(kRounded),
                                                                                          color: Colors.transparent,
                                                                                          child: InkWell(
                                                                                            borderRadius: BorderRadius.circular(kRounded),
                                                                                            onTap: () async {
                                                                                              if (shouldEdit) {
                                                                                                Navigator.pop(context);
                                                                                                await editSong(songList[indexOfList].data, titleOfSong, albumOfSong, artistOfSong, genreOfSong);
                                                                                                refresh = true;
                                                                                                await Future.delayed(Duration(seconds: 1));
                                                                                                rootState.provideman();
                                                                                              }
                                                                                            },
                                                                                            child: Container(
                                                                                              height: deviceWidth / 12,
                                                                                              width: deviceWidth / 4,
                                                                                              decoration: BoxDecoration(
                                                                                                boxShadow: [
                                                                                                  BoxShadow(
                                                                                                    color: Colors.black12,
                                                                                                    blurRadius: 1.0,
                                                                                                    spreadRadius: deviceWidth / 220,
                                                                                                  ),
                                                                                                ],
                                                                                                color: Color(0xFF1DB954),
                                                                                                borderRadius: BorderRadius.circular(kRounded),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Text("DONE", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: deviceWidth / 25, fontWeight: FontWeight.w600)),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(padding: EdgeInsets.only(top: orientedCar ? widthOfDevice / 16 : heightOfDevice / 40)),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ));
                                                        } catch (e) {
                                                          Flushbar(
                                                            message:
                                                                "The File Might be Unsupported/Corrupted.",
                                                            icon: Icon(
                                                              Icons
                                                                  .info_outline,
                                                              size: 28.0,
                                                              color: Color(
                                                                  0xFFCB0447),
                                                            ),
                                                            shouldIconPulse:
                                                                true,
                                                            borderColor: Colors
                                                                .white
                                                                .withOpacity(
                                                                    0.04),
                                                            borderWidth: 1,
                                                            backgroundColor:
                                                                glassOpacity,
                                                            flushbarStyle:
                                                                FlushbarStyle
                                                                    .FLOATING,
                                                            isDismissible: true,
                                                            barBlur: musicBox.get(
                                                                        "glassBlur") ==
                                                                    null
                                                                ? 18
                                                                : musicBox.get(
                                                                    "glassBlur"),
                                                            dismissDirection:
                                                                FlushbarDismissDirection
                                                                    .HORIZONTAL,
                                                            duration: Duration(
                                                                seconds: 5),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 20,
                                                                    left: 8,
                                                                    right: 8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          )..show(context);
                                                        }
                                                      }
                                                    } else if (i == 5) {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => Ringtone(
                                                              artworkId: nowMediaItem
                                                                  .extras['id'],
                                                              filePath:
                                                                  nowMediaItem
                                                                      .id,
                                                              artist:
                                                                  nowMediaItem
                                                                      .artist,
                                                              title:
                                                                  nowMediaItem
                                                                      .title,
                                                              songDuration:
                                                                  nowMediaItem
                                                                          .duration
                                                                          .inMilliseconds *
                                                                      1.0),
                                                        ),
                                                      );
                                                    } else if (i == 6) {
                                                      // Save Wallpaper
                                                      if (await Permission
                                                              .storage
                                                              .request()
                                                              .isGranted
                                                          //     &&
                                                          // await Permission
                                                          //     .manageExternalStorage
                                                          //     .request()
                                                          //     .isGranted
                                                          ) {
                                                        Navigator.pop(context);

                                                        Flushbar(
                                                          messageText: Text(
                                                              "Saved In Downloads Directory",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Futura",
                                                                  color: Colors
                                                                      .white)),
                                                          icon: Icon(
                                                            MdiIcons.image,
                                                            size: 28.0,
                                                            color: kCorrect,
                                                          ),

                                                          shouldIconPulse: true,
                                                          dismissDirection:
                                                              FlushbarDismissDirection
                                                                  .HORIZONTAL,
                                                          duration: Duration(
                                                              seconds: 5),
                                                          borderColor: Colors
                                                              .white
                                                              .withOpacity(
                                                                  0.04),
                                                          borderWidth: 1,
                                                          backgroundColor:
                                                              Colors.white
                                                                  .withOpacity(
                                                                      0.05),
                                                          flushbarStyle:
                                                              FlushbarStyle
                                                                  .FLOATING,
                                                          isDismissible: true,
                                                          barBlur: 20,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20,
                                                                  left: 8,
                                                                  right: 8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          // leftBarIndicatorColor:
                                                          //     Color(0xFFCB0047),
                                                        )..show(context);
                                                        await Future.delayed(
                                                            Duration(
                                                                seconds: 1));
                                                        await screenShotUI(
                                                            true);
                                                      }
                                                    } else if (i == 7) {
                                                      // set as home screen
                                                      Navigator.pop(context);
                                                      await screenShotUI(false);
                                                      await setHomeScreenWallpaper();
                                                    } else if (i == 8) {
                                                      if (isAndroid11) {
                                                        androidRSupport(
                                                            context);
                                                      } else {
                                                        if (await Permission
                                                                .storage
                                                                .request()
                                                                .isGranted
                                                            //     &&
                                                            // await Permission
                                                            //     .manageExternalStorage
                                                            //     .request()
                                                            //     .isGranted
                                                            ) {
                                                          await deleteAFile(
                                                              songList[
                                                                      indexOfList]
                                                                  .data);
                                                          Navigator.pop(
                                                              context);
                                                          await Future.delayed(
                                                              Duration(
                                                                  seconds: 2));

                                                          refresh = true;
                                                          rootState
                                                              .provideman();
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        i == 1
                                                            ? !isSongLiked(
                                                                    nowMediaItem
                                                                        .id)
                                                                ? "Remove From Liked Songs"
                                                                : "Add to Liked Songs"
                                                            : songMoreInfoNP[i],
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          color: musicBox.get(
                                                                      "dynamicArtDB") ??
                                                                  true
                                                              ? Colors.white70
                                                              : darkModeOn
                                                                  ? Colors
                                                                      .white70
                                                                  : Colors
                                                                      .black87,
                                                          fontSize: car
                                                              ? widthOfDevice /
                                                                  26
                                                              : heightOfDevice /
                                                                  56,
                                                          shadows: [
                                                            Shadow(
                                                              offset: musicBox.get(
                                                                          "dynamicArtDB") ??
                                                                      true
                                                                  ? Offset(
                                                                      0, 1.0)
                                                                  : darkModeOn
                                                                      ? Offset(
                                                                          0,
                                                                          1.0)
                                                                      : Offset(
                                                                          0,
                                                                          0.5),
                                                              blurRadius:
                                                                  musicBox.get(
                                                                              "dynamicArtDB") ??
                                                                          true
                                                                      ? 3.0
                                                                      : darkModeOn
                                                                          ? 3.0
                                                                          : 2.0,
                                                              color: darkModeOn
                                                                  ? Colors
                                                                      .black54
                                                                  : Colors
                                                                      .black38,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: car
                                            ? widthOfDevice / 12
                                            : heightOfDevice / 25),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );
}
