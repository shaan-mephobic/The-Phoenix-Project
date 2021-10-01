import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/utilities/global_variables.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class NowArt extends StatelessWidget {
  final bool car;
  NowArt(this.car);
  @override
  Widget build(BuildContext context) {
    return Consumer<Leprovider>(
      builder: (context, timing, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRounded),
            boxShadow: [nowArtShadow],
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: isPlayerShown
                ? QueryArtworkWidget(
                    id: nowMediaItem.extras["id"],
                    type: ArtworkType.AUDIO,
                    format: ArtworkFormat.JPEG,
                    size: 600,
                    artworkQuality: FilterQuality.high,
                    keepOldArtwork: true,
                    nullArtworkWidget: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRounded),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(defaultNone),
                          ),
                        ),
                      ),
                    ),
                    artworkBorder: BorderRadius.circular(kRounded),
                    artworkFit: BoxFit.cover)
                : AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(defaultNone),
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class NowArtLandScape extends StatelessWidget {
  final bool car;
  NowArtLandScape(this.car);
  @override
  Widget build(BuildContext context) {
    return Consumer<Leprovider>(
      builder: (context, timing, child) {
        return Container(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: isPlayerShown
                ? QueryArtworkWidget(
                    id: nowMediaItem.extras["id"],
                    type: ArtworkType.AUDIO,
                    format: ArtworkFormat.JPEG,
                    size: 600,
                    artworkQuality: FilterQuality.high,
                    keepOldArtwork: true,
                    nullArtworkWidget: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(defaultNone),
                        ),
                      ),
                    ),
                    artworkBorder: BorderRadius.circular(kRounded),
                    artworkFit: BoxFit.cover)
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRounded),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(defaultNone),
                      ),
                    ),
                  ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRounded),
              boxShadow: [nowArtShadow]),
        );
      },
    );
  }
}
