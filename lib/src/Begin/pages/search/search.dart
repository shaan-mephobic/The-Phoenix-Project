import 'dart:ui';
import 'package:flutter_remixicon/flutter_remixicon.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/on_hold.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../begin.dart';

var globalastro;

class Searchin extends StatefulWidget {
  @override
  _SearchinState createState() => _SearchinState();
}

class _SearchinState extends State<Searchin> {
  ScrollController _scrollBarController;

  @override
  void initState() {
    focusManager();
    crossfadeStateChange = true;
    _scrollBarController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    crossfadeStateChange = false;
    super.dispose();
  }

  var focusNode = FocusNode();

  theSearch(name) async {
    if (name != "") {
      List<SongModel> tracks = [];
      // TODO Change UI to make seperate sections of types
      for (int i = 0; i < songList.length; i++) {
        if (songList[i].title.toUpperCase().contains(name.toUpperCase()) ||
            songList[i].artist.toUpperCase().contains(name.toUpperCase()) ||
            songList[i].album.toUpperCase().contains(name.toUpperCase())) {
          tracks.add(songList[i]);
        }
      }
      globalastro.thesearch(tracks.toSet().toList());
    } else {
      globalastro.thesearch([]);
    }
  }

  focusManager() async {
    await Future.delayed(Duration(milliseconds: 150));
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Leprovider>(
      builder: (context, taste, _) {
        globaltaste = taste;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Theme(
            data: themeOfApp,
            child: Stack(
              children: [
                BackArt(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                color: Colors.black
                                    .withOpacity(glassShadowOpacity / 100),
                                blurRadius: glassShadowBlur,
                                offset: kShadowOffset,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(kRounded),
                          ),
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
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  cursorColor: Color(0xFF3cb9cd),
                                  focusNode: focusNode,
                                  autofocus: false,
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (thetext) {
                                    theSearch(thetext);
                                  },
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    suffixIcon: Icon(Icons.music_note_rounded,
                                        color: Colors.white),
                                    prefixIcon: Hero(
                                      tag: "aslongasiwakeup",
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Icon(
                                          MIcon.riSearchLine,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[350]),
                                    hintText:
                                        "Search for songs,albums,artists...",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Consumer<Astronautintheocean>(
                      builder: (context, astronaut, child) {
                        globalastro = astronaut;
                        var dumps = astronaut.searchen;
                        return Expanded(
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
                                itemCount: astronaut.searchen.length,
                                itemBuilder: (context, index) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: ListTile(
                                      onTap: () async {
                                        var songindex = 0;
                                        for (int si = 0;
                                            si < songList.length;
                                            si++) {
                                          if (dumps[index].id ==
                                              songList[si].id) {
                                            songindex = si;
                                          }
                                        }
                                        if (songListMediaItems[index]
                                                .duration ==
                                            Duration(milliseconds: 0)) {
                                          corruptedFile(context);
                                        } else {
                                          await playThis(songindex, "all");
                                        }
                                      },
                                      onLongPress: () async {
                                        int indexThis;
                                        for (int si = 0;
                                            si < songList.length;
                                            si++) {
                                          if (dumps[index].data ==
                                              songList[si].data) {
                                            indexThis = si;
                                            await onHold(
                                                context,
                                                songList,
                                                indexThis,
                                                orientedCar,
                                                deviceHeight,
                                                deviceWidth,
                                                "all");
                                          }
                                        }
                                      },
                                      dense: false,
                                      title: Text(
                                        dumps[index].title,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white70,
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
                                          dumps[index].artist,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white70,
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
                                          constraints:
                                              musicBox.get("squareArt") ?? true
                                                  ? kSqrConstraint
                                                  : kRectConstraint,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(albumsArts[
                                                        dumps[index].album] ??
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
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
