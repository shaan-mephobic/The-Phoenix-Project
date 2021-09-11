import 'dart:ui';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import '../../utilities/page_backend/genres_back.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:phoenix/src/Begin/widgets/list_header.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/on_hold.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../begin.dart';
import 'genres.dart';

List insidegenreSongs = [];

class GenresInside extends StatefulWidget {
  @override
  _GenresInsideState createState() => _GenresInsideState();
}

class _GenresInsideState extends State<GenresInside> {
  ScrollController _scrollBarController;

  @override
  void initState() {
    crossfadeStateChange = true;
    _scrollBarController = ScrollController();
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Hero(
              tag: "crossfire-$genreSelected",
              child: Text(
                musicBox.get('customScan') ?? false
                    ? insideAllGenreData.keys.toList()[genreSelected]
                    : allgenres[genreSelected].genre,
                style: TextStyle(
                  inherit: false,
                  fontSize: deviceWidth / 18,
                  fontFamily: "Urban",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          body: Theme(
            data: themeOfApp,
            child: Stack(
              children: [
                BackArt(),
                Container(
                  padding: EdgeInsets.only(top: deviceWidth / 4.3),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Scrollbar(
                      controller: _scrollBarController,
                      child: ListView.builder(
                        controller: _scrollBarController,
                        padding: EdgeInsets.only(top: 5, bottom: 8),
                        physics: musicBox.get("fluidAnimation") ?? true
                            ? BouncingScrollPhysics()
                            : ClampingScrollPhysics(),
                        itemCount: genreSongs.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return ListHeader(deviceWidth, genreSongs, "genre");
                          }
                          return Material(
                            color: Colors.transparent,
                            child: ListTile(
                              onTap: () async {
                                if (genreMediaItems[index - 1].duration ==
                                    Duration(milliseconds: 0)) {
                                  corruptedFile(context);
                                } else {
                                  insidegenreSongs = [];
                                  insidegenreSongs = genreSongs;
                                  await playThis(index - 1, "genre");
                                }
                              },
                              onLongPress: () async {
                                Expanded(
                                  child: await onHold(
                                      context,
                                      genreSongs,
                                      index - 1,
                                      orientedCar,
                                      deviceHeight,
                                      deviceWidth,
                                      "genre"),
                                );
                              },
                              dense: false,
                              title: Text(
                                genreSongs[index - 1].title,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white70,
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
                                  genreSongs[index - 1].artist,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'Urban',
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
                                                genreSongs[index - 1].album] ??
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
          ),
        );
      },
    );
  }
}
