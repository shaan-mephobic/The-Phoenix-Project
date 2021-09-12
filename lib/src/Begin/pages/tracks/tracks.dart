import 'dart:ui';
import 'package:audiotagger/audiotagger.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/utilities/init.dart';
import 'package:phoenix/src/Begin/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/Begin/widgets/list_header.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import '../../begin.dart';
import '../../widgets/dialogues/on_hold.dart';


class Allofem extends StatefulWidget {
  @override
  _AllofemState createState() => _AllofemState();
}

class _AllofemState extends State<Allofem>
    with AutomaticKeepAliveClientMixin<Allofem> {
  ScrollController _scrollBarController;
  @override
  void initState() {
    _scrollBarController = ScrollController();
    tagger = Audiotagger();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    super.build(context);
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }

    if (!isPlayerShown) {
      pc.hide();
    }
    return Scrollbar(
      controller: _scrollBarController,
      child: RefreshIndicator(
        backgroundColor:
            musicBox.get("dynamicArtDB") ?? true ? nowColor : Colors.white,
        color:
            musicBox.get("dynamicArtDB") ?? true ? nowContrast : kMaterialBlack,
        onRefresh: () async {
          await fetchAll();
        },
        child: ListView.builder(
          controller: _scrollBarController,
          padding: EdgeInsets.only(top: 3, bottom: 8),
          addAutomaticKeepAlives: true,
          physics: musicBox.get("fluidAnimation") ?? true
              ? BouncingScrollPhysics()
              : ClampingScrollPhysics(),
          itemCount: songList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListHeader(deviceWidth, songList, "all");
            }
            return Material(
              color: Colors.transparent,
              child: ListTile(
                onTap: () async {
                  if (songListMediaItems[index - 1].duration ==
                      Duration(milliseconds: 0)) {
                    corruptedFile(context);
                  } else {
                    await playThis(index - 1, "all");
                  }
                },
                onLongPress: () async {
                  Expanded(
                      child: await onHold(context, songList, index - 1,
                          orientedCar, deviceHeight, deviceWidth, "all"));
                },
                dense: false,
                title: Text(
                  songList[index - 1].title,
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
                    songList[index - 1].artist,
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
                          image: MemoryImage(
                              albumsArts[songList[index - 1].album] ??
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
    );
  }
}
