import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/beginning/widgets/artwork_background.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/corrupted_file_dialog.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:phoenix/src/beginning/widgets/list_header.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/page_backend/playlist_back.dart';

List<SongModel> playlistSongsInside = [];
List<SongModel>? insideplaylistSongsInside = [];
List<MediaItem> playlistMediaItems = [];

class PlaylistInside extends StatefulWidget {
  final String? playlistName;
  const PlaylistInside({Key? key, required this.playlistName})
      : super(key: key);
  @override
  _PlaylistInsideState createState() => _PlaylistInsideState();
}

class _PlaylistInsideState extends State<PlaylistInside> {
  ScrollController? _scrollBarController;
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
    return Consumer<Leprovider>(builder: (context, taste, _) {
      globaltaste = taste;
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text(
            widget.playlistName!,
            style: TextStyle(
                color: Colors.white,
                fontSize: deviceWidth! / 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Theme(
          data: themeOfApp,
          child: Stack(
            children: [
              // ignore: prefer_const_constructors
              BackArt(),
              Padding(
                padding: EdgeInsets.only(top: deviceWidth! / 5),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Scrollbar(
                    controller: _scrollBarController,
                    child: ReorderableListView.builder(
                        scrollController: _scrollBarController,
                        padding: const EdgeInsets.only(top: 0, bottom: 8),
                        physics: musicBox.get("fluidAnimation") ?? true
                            ? const BouncingScrollPhysics()
                            : const ClampingScrollPhysics(),
                        header: ListHeader(
                            deviceWidth, playlistSongsInside, "playlist"),
                        itemCount: playlistSongsInside.length,
                        itemBuilder: (context, index) {
                          final String kee =
                              playlistSongsInside[index].id.toString();
                          return Material(
                            color: Colors.transparent,
                            key: ValueKey(kee),
                            child: ListTile(
                              onTap: () async {
                                if (playlistMediaItems[index].duration ==
                                    const Duration(milliseconds: 0)) {
                                  corruptedFile(context);
                                } else {
                                  insideplaylistSongsInside =
                                      playlistSongsInside;
                                  await playThis(index, "playlist");
                                }
                              },
                              dense: false,
                              title: Text(
                                playlistSongsInside[index].title,
                                maxLines: 2,
                                style: const TextStyle(
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
                                  playlistSongsInside[index].artist!,
                                  maxLines: 1,
                                  style: const TextStyle(
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
                              trailing: Material(
                                color: Colors.transparent,
                                child: ReorderableDragStartListener(
                                  index: index,
                                  child: const Icon(Icons.drag_handle),
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
                                            // albumsArts[
                                            //       playlistSongsInside[index]
                                            //           .album!] ??
                                            //   defaultNone!
                                            artworksData[(musicBox.get(
                                                        "artworksPointer") ??
                                                    {})[playlistSongsInside[
                                                        index]
                                                    .id]] ??
                                                defaultNone!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        onReorder: (oldIndex, newIndex) async {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex = newIndex - 1;
                            }
                            final element =
                                playlistSongsInside.removeAt(oldIndex);
                            playlistSongsInside.insert(newIndex, element);
                          });
                          updateQueuePlayList(
                              widget.playlistName, playlistSongsInside);
                          playlistMediaItems = [];
                          playlistSongsInside = [];
                          await fetchPlaylistSongs(widget.playlistName);
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
