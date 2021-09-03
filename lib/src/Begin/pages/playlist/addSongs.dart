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
  ScrollController _scrollBarController;

  @override
  void initState() {
    _scrollBarController = ScrollController();
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
    return Consumer<Leprovider>(
      builder: (context, taste, _) {
        globaltaste = taste;
        return Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                      style: TextStyle(
                          fontFamily: "FuturaR", color: Colors.white)),
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
                )..show(context);
              } else {
                newPlaylist(playListName, playListSongsId);
                Navigator.pop(context);
              }
            },
          ),
          body: Theme(
            data: themeOfApp,
            child: Stack(children: [
              BackArt(),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  Container(
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
                                textAlignVertical: TextAlignVertical.center,
                                cursorColor: Color(0xFF3cb9cd),
                                autofocus: false,
                                style: TextStyle(color: Colors.white),
                                onChanged: (thetext) {
                                  playListName = thetext;
                                },
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey[350],
                                  ),
                                  hintText: playListName,
                                  prefixIcon: Icon(
                                      MdiIcons.playlistMusicOutline,
                                      color: Colors.white),
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
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Scrollbar(
                        controller: _scrollBarController,
                        child: ListView.builder(
                          controller: _scrollBarController,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 0, bottom: 8),
                          addAutomaticKeepAlives: true,
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
                                      playListSongsId
                                          .remove(songList[index].data);
                                    } else {
                                      playListCheck[index] = false;
                                      modifyPlayList
                                          .remove(songList[index].data);
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
                                        playListSongsId
                                            .remove(songList[index].data);
                                      } else {
                                        playListCheck[index] = false;
                                        modifyPlayList
                                            .remove(songList[index].data);
                                      }
                                    } else {
                                      if (!modify) {
                                        playListCheck[index] = true;
                                        playListSongsId
                                            .add(songList[index].data);
                                      } else {
                                        playListCheck[index] = true;
                                        modifyPlayList
                                            .add(songList[index].data);
                                      }
                                    }
                                    setState(() {});
                                  },
                                ),
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
                                          image: MemoryImage(albumsArts[
                                                  songList[index].album] ??
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
                    ),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
