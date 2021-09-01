import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import '../../utilities/page_backend/playlist_back.dart';
import 'package:phoenix/src/Begin/pages/playlist/playlist.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:provider/provider.dart';
import '../../begin.dart';

List<bool> playListCheck = [];
List playListSongsId = [];
String playListName = "Enter Playlist Name";

class AddSongs extends StatefulWidget {
  @override
  _AddSongsState createState() => _AddSongsState();
}

class _AddSongsState extends State<AddSongs> {
  @override
  void initState() {
    crossfadeStateChange = true;
    super.initState();
  }

  @override
  void dispose() {
    crossfadeStateChange = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Leprovider>(builder: (context, taste, _) {
      globaltaste = taste;
      return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          splashColor: Colors.transparent,
          icon: Icon(Icons.check_rounded, color: Colors.black),
          label: Text(modify ? "MODIFY" : "CREATE",
              style: TextStyle(
                  inherit: false,
                  color: Colors.black,
                  fontSize: deviceWidth / 25,
                  fontFamily: 'UrbanSB')),
          backgroundColor: Color(0xFF1DB954),
          elevation: 8.0,
          onPressed: () {
            if (playListName == "Enter Playlist Name") {
              Flushbar(
                messageText: Text("Enter a Playlist Name! ¯\\_(ツ)_/¯",
                    style:
                        TextStyle(fontFamily: "FuturaR", color: Colors.white)),
                icon: Icon(
                  Icons.error_outline,
                  size: 28.0,
                  color: Color(0xFFCB0447),
                ),

                shouldIconPulse: true,
                dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                duration: Duration(seconds: 5),
                borderColor: Colors.white.withOpacity(0.04),
                borderWidth: 1,
                backgroundColor: Colors.white.withOpacity(0.05),
                flushbarStyle: FlushbarStyle.FLOATING,
                isDismissible: true,
                barBlur: 20,
                margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                borderRadius: BorderRadius.circular(15),
                // leftBarIndicatorColor:
                //     Color(0xFFCB0047),
              )..show(context);
            } else {
              newPlaylist(playListName, playListSongsId);
              Navigator.pop(context);
            }
          },
        ),
        body: Stack(children: [
          // Container(
          //   decoration: musicBox.get("dynamicArtDB") ?? true
          //       ? BoxDecoration(
          //           image: DecorationImage(
          //             image: MemoryImage(first ? art : art2),
          //             fit: BoxFit.cover,
          //           ),
          //         )
          //       : BoxDecoration(color: kMaterialBlack),
          //   child: ClipRRect(
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          //       child: Container(
          //         alignment: Alignment.center,
          //         color: Colors.black.withOpacity(0.2),
          // child:
          // musicBox.get("dynamicArtDB") ?? true
          // ?
          BackArt(),
          // : Container(color: kMaterialBlack),

          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              Container(
                // height: deviceHeight / 7,
                padding: EdgeInsets.only(left: 10, right: 10),

                height: 120,

                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15.0,
                          offset: kShadowOffset,
                          // spreadRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(kRounded),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRounded),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRounded),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.04),
                            ),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: TextField(
                            cursorColor: Color(0xFF3cb9cd),
                            autofocus: false,
                            style: TextStyle(color: Colors.white),
                            onChanged: (thetext) {
                              playListName = thetext;
                              // print(thetext);
                            },
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              // borderRadius: BorderRadius.all(
                              // Radius.circular(25.0),
                              // ),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              // filled: true,
                              hintStyle: TextStyle(
                                color: Colors.grey[350],
                                // inherit: false,
                              ),
                              hintText: playListName,
                              prefixIcon: Icon(MdiIcons.playlistMusicOutline,
                                  color: Colors.white),
                              // fillColor: Colors.black87,
                              suffixIcon: Visibility(
                                visible: modify,
                                child: IconButton(
                                  icon: Icon(Ionicons.trash_outline,
                                      color: Color(0xFFCB0047)),
                                  onPressed: () {
                                    removePlaylists(
                                        playListName, prePlayListName);
                                    Navigator.pop(context);
                                  },
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
              // Container(
              // padding: EdgeInsets.only(top: deviceWidth / 10),
              // width: deviceWidth,
              // height: deviceHeight - deviceWidth / 4.3,
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 0, bottom: 8),
                  addAutomaticKeepAlives: true,
                  // itemExtent: deviceWidth / 6,
                  physics: musicBox.get("fluidAnimation") ?? true
                      ? BouncingScrollPhysics()
                      : ClampingScrollPhysics(),
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          if (playListCheck[index]) {
                            if (!modify) {
                              playListCheck[index] = false;
                              playListSongsId.remove(songList[index].data);
                            } else {
                              playListCheck[index] = false;
                              modifyPlayList.remove(songList[index].data);
                            }
                          } else {
                            if (!modify) {
                              playListCheck[index] = true;
                              playListSongsId.add(songList[index].data);
                            } else {
                              playListCheck[index] = true;
                              modifyPlayList.add(songList[index].data);
                            }
                          }
                          setState(() {});
                        },
                        dense: false,
                        enabled: true,
                        title: Text(
                          songList[index].title,
                          maxLines: 2,
                          style: TextStyle(
                            // fontSize: deviceWidth / 28,
                            color: Colors.white70,
                            fontFamily: 'UrbanR',
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1.0),
                                blurRadius: 3.0,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                        tileColor: Colors.transparent,
                        subtitle: Text(
                          songList[index].artist,
                          maxLines: 1,
                          style: TextStyle(
                            // fontSize: deviceWidth / 34,
                            fontFamily: 'UrbanR',
                            color: Colors.white38,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                        trailing: Checkbox(
                          activeColor: Color(0xFF1DB954),
                          value: playListCheck[index],
                          onChanged: (_) {
                            if (playListCheck[index]) {
                              if (!modify) {
                                playListCheck[index] = false;
                                playListSongsId.remove(songList[index].data);
                              } else {
                                playListCheck[index] = false;
                                modifyPlayList.remove(songList[index].data);
                              }
                            } else {
                              if (!modify) {
                                playListCheck[index] = true;
                                playListSongsId.add(songList[index].data);
                              } else {
                                playListCheck[index] = true;
                                modifyPlayList.add(songList[index].data);
                              }
                            }
                            setState(() {});
                          },
                        ),
                        // leading: Card(
                        //   elevation: deviceWidth / 160,
                        //   color: Colors.transparent,
                        //   child:
                        //   // Stack(
                        //   //   children: [
                        //   //     Container(
                        //   //       // alignment: Alignment.center,
                        //   //       height: deviceWidth / 10.4,
                        //   //       width: deviceWidth / 10.4,
                        //   //       decoration: BoxDecoration(
                        //   //         color: nowColor,
                        //   //         borderRadius: BorderRadius.circular(3),
                        //   //       ),
                        //   //       child: Center(
                        //   //         child: Icon(
                        //   //           Icons.music_note_outlined,
                        //   //           color: nowContrast,
                        //   //         ),
                        //   //       ),
                        //   //     ),
                        //       Container(
                        //         // height: deviceWidth / 10,
                        //         // width: deviceWidth / 10,
                        //         // child: QueryArtworkWidget(
                        //         //     deviceInfo: deviceInfo,
                        //         //     artwork: songList[index].artwork,
                        //         //     id: songList[index].id,
                        //         //     type: ArtworkType.AUDIO,
                        //         //     keepOldArtwork: true,
                        //         //     nullArtworkWidget: Container(
                        //         //       height: deviceWidth / 10,
                        //         //       width: deviceWidth / 10,
                        //         //       decoration: BoxDecoration(
                        //         //         borderRadius:
                        //         //             BorderRadius.circular(3),
                        //         //         image: DecorationImage(
                        //         //           fit: BoxFit.contain,
                        //         //           image: MemoryImage(defaultNone),
                        //         //         ),
                        //         //       ),
                        //         //     ),
                        //         //     artworkBorder: BorderRadius.circular(3),
                        //         //     artworkFit: BoxFit.cover),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(3),
                        //           image: DecorationImage(
                        //             fit: BoxFit.cover,
                        //             image: MemoryImage(
                        //                 albumsArts[songList[index].album] ??
                        //                     defaultNone),
                        //           ),
                        //         ),
                        //       ),
                        //   //   ],
                        //   // ),
                        // ),
                        leading: Card(
                          elevation: 3,
                          color: Colors.transparent,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              // minWidth: 44,
                              // minHeight: 44,
                              // maxWidth: 64,
                              // maxHeight: 64,
                              minWidth: 48,
                              minHeight: 48,
                              maxWidth: 48,
                              maxHeight: 48,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(
                                      albumsArts[songList[index].album] ??
                                          defaultNone),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ]),
      );
    });
  }
}
