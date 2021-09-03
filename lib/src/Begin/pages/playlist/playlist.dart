import 'dart:ui';
import 'package:phoenix/src/Begin/pages/playlist/playlist_inside.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/playlist_back.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:provider/provider.dart';
import '../../begin.dart';
import 'addSongs.dart';

int playlistIndex;
bool modify = false;
String prePlayListName;
List modifyPlayList = [];

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  ScrollController _scrollBarController;
  @override
  void initState() {
    _scrollBarController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (musicBox.get('playlists') == null) {
      return Container(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 13.0,
                    offset: kShadowOffset,
                    // spreadRadius: 5,
                  ),
                ],
                // color: Colors.black12,
                borderRadius: BorderRadius.circular(kRounded),
              ),
              width: deviceWidth / 1.7,
              height: deviceWidth / 8,
              child: InkWell(
                borderRadius: BorderRadius.circular(kRounded),
                onTap: () {
                  // input playlist name
                  playlistSongsSelected(false);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<Leprovider>(
                                create: (_) => Leprovider(),
                                builder: (context, child) => AddSongs()),
                      ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kRounded),

                  // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.04)),
                        color: Colors.white.withOpacity(0.05),
                      ),
                      // color: Colors.black.withOpacity(0.2),
                      child: Center(
                        child: Text(
                          'Create Playlist',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "UrbanSB",
                            fontSize: deviceWidth / 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.transparent,
          child: Icon(Icons.add_rounded, color: Colors.black),
          backgroundColor: Color(0xFF1DB954),
          elevation: 8.0,
          onPressed: () {
            playlistSongsSelected(false);
            playListSongsId = [];
            playListName = "Enter Playlist Name";
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider<Leprovider>(
                      create: (_) => Leprovider(),
                      builder: (context, child) => AddSongs()),
                ));
          },
        ),
        body: Scrollbar(
          controller: _scrollBarController,
          child: ListView.builder(
            controller: _scrollBarController,
            padding: EdgeInsets.only(top: 5, bottom: 8),
            addAutomaticKeepAlives: true,
            // itemExtent: deviceWidth / 2,
            itemExtent: orientedCar ? deviceWidth / 1.4 : deviceWidth / 2,

            physics: musicBox.get("fluidAnimation") ?? true
                ? BouncingScrollPhysics()
                : ClampingScrollPhysics(),
            itemCount: musicBox.get('playlists').length,
            itemBuilder: (context, index) {
              return Container(
                height: orientedCar ? deviceHeight / 3 : deviceWidth / 2,
                width: orientedCar ? deviceHeight : deviceWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: deviceWidth / 25),
                    ),

                    Container(
                      width:
                          orientedCar ? deviceHeight / 1.4 : deviceWidth / 1.05,
                      height:
                          orientedCar ? deviceHeight / 3.3 : deviceWidth / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 13.0,
                              offset: kShadowOffset),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kRounded),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kRounded),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.04)),
                                color: Colors.white.withOpacity(0.05),
                              ),
                              alignment: Alignment.center,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(kRounded),
                                onTap: () async {
                                  modify = false;
                                  playlistIndex = index;
                                  playlistMediaItems = [];
                                  playlistSongsInside = [];
                                  await fetchPlaylistSongs();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider<Leprovider>(
                                                create: (_) => Leprovider(),
                                                builder: (context, child) =>
                                                    PlaylistInside()),
                                      ));
                                },
                                onLongPress: () {
                                  modify = true;
                                  playListName = musicBox
                                      .get('playlists')
                                      .keys
                                      .toList()[index];
                                  modifyPlayList =
                                      musicBox.get('playlists')[playListName];
                                  prePlayListName = playListName;
                                  playlistSongsSelected(true);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider<Leprovider>(
                                                create: (_) => Leprovider(),
                                                builder: (context, child) =>
                                                    AddSongs()),
                                      ));
                                },
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      musicBox
                                          .get('playlists')
                                          .keys
                                          .toList()[index],
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                          inherit: false,
                                          color: Colors.white,
                                          fontSize: deviceWidth / 20,
                                          fontFamily: "UrbanSB"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
