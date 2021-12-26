import 'package:page_transition/page_transition.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/beginning/widgets/list_header.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/on_hold.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'albums.dart';
import '../../utilities/page_backend/albums_back.dart';

Color? dominantAlbum;
Color? contrastAlbum;

class AlbumsInside extends StatelessWidget {
  const AlbumsInside({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Theme(
        data: themeOfApp,
        child: Container(
          color: musicBox.get("dynamicArtDB") ?? true
              ? dominantAlbum
              : kMaterialBlack,
          child: CustomScrollView(
            physics: musicBox.get("fluidAnimation") ?? true
                ? const BouncingScrollPhysics()
                : const ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: musicBox.get("dynamicArtDB") ?? true
                      ? contrastAlbum
                      : Colors.white,
                ),
                expandedHeight: 380,
                backgroundColor: musicBox.get("dynamicArtDB") ?? true
                    ? dominantAlbum
                    : kMaterialBlack,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: const EdgeInsets.all(0),
                  background: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 80)),
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRounded),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(kRounded),
                            child: Image.memory(
                              albumsArts[allAlbums[passedIndexAlbum!].album] ??
                                  defaultNone!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        inAlbumSongs[0].album!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          shadows:const  [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 2.2,
                              color: Colors.black26,
                            ),
                          ],
                          fontSize: deviceHeight! / 39,
                          color: musicBox.get("dynamicArtDB") ?? true
                              ? contrastAlbum
                              : Colors.white,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 2)),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          inAlbumSongs[0].artist!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            shadows:const  [
                              Shadow(
                                offset: Offset(0, 1.8),
                                blurRadius: 2.2,
                                color: Colors.black26,
                              ),
                            ],
                            fontSize: deviceHeight! / 57,
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? contrastAlbum
                                : Colors.white,
                          ),
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
                      return ListHeader(deviceWidth, inAlbumSongs, "album");
                    }
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () async {
                          // insideInAlbumSongs = [];
                          if (albumMediaItems[index - 1].duration ==
                              const Duration(milliseconds: 0)) {
                            corruptedFile(context);
                          } else {
                            insideInAlbumSongs = inAlbumSongs;
                            await playThis(index - 1, "album");
                          }
                        },
                        onLongPress: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.size,
                              alignment: Alignment.center,
                              duration: dialogueAnimationDuration,
                              reverseDuration: dialogueAnimationDuration,
                              child: OnHold(
                                  classContext: context,
                                  listOfSong: inAlbumSongs,
                                  index: index - 1,
                                  car: orientedCar,
                                  heightOfDevice: deviceHeight,
                                  widthOfDevice: deviceWidth,
                                  songOf: "album"),
                            ),
                          );
                        },
                        dense: false,
                        title: Text(
                          inAlbumSongs[index - 1].title,
                          maxLines: 2,
                          style: TextStyle(
                            color: musicBox.get("dynamicArtDB") ?? true
                                ? contrastAlbum
                                : Colors.white,
                            shadows: const [
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
                            inAlbumSongs[index - 1].artist!,
                            maxLines: 1,
                            style: TextStyle(
                              color: musicBox.get("dynamicArtDB") ?? true
                                  ? contrastAlbum
                                  : Colors.white,
                              shadows: const [
                                Shadow(
                                  offset: Offset(0, 1.0),
                                  blurRadius: 1.0,
                                  color: Colors.black38,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: inAlbumSongs.length + 1,
                  addAutomaticKeepAlives: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future albumColor(image) async {
  PaletteGenerator paletteGenerator;
  paletteGenerator = await PaletteGenerator.fromImageProvider(image);
  dominantAlbum = (paletteGenerator.dominantColor!.color);
  if (dominantAlbum!.computeLuminance() <= 0.5) {
    try {
      var pal = paletteGenerator.lightMutedColor!.color;
      contrastAlbum = pal;
    } catch (e) {
      contrastAlbum = Colors.white;
    }

    if (dominantAlbum == contrastAlbum) {
      contrastAlbum = paletteGenerator.darkMutedColor!.color;
    }
  } else {
    try {
      var pal = (paletteGenerator.darkMutedColor!.color);
      contrastAlbum = pal;
    } catch (e) {
      contrastAlbum = Colors.black;
    }
    if (dominantAlbum == contrastAlbum) {
      contrastAlbum = paletteGenerator.lightMutedColor!.color;
    }
  }
  if ((dominantAlbum!.computeLuminance() - contrastAlbum!.computeLuminance())
          .abs() <
      0.2) {
    if (dominantAlbum!.computeLuminance() < 0.5) {
      contrastAlbum = Colors.white;
    } else {
      contrastAlbum = Colors.black;
    }
  }
}
