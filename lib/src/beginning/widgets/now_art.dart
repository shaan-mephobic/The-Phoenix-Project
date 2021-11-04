import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NowArt extends StatelessWidget {
  final bool car;
  const NowArt(this.car, {Key? key}) : super(key: key);
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
                ? AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(artworksData[
                                  (musicBox.get("artworksPointer") ??
                                      {})[nowMediaItem.extras!["id"]]] ??
                              defaultNone!),
                        ),
                      ),
                    ),
                  )
                : AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(defaultNone!),
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
  const NowArtLandScape(this.car, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<Leprovider>(
      builder: (context, timing, child) {
        return Container(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: isPlayerShown
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRounded),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(artworksData[
                                (musicBox.get("artworksPointer") ??
                                    {})[nowMediaItem.extras!["id"]]] ??
                            defaultNone!),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRounded),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(defaultNone!),
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
