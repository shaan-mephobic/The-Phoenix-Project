import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_edit/on_audio_edit.dart' as on_audio_edit;
import 'package:palette_generator/palette_generator.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import '../../widgets/artwork_background.dart';

playerontap() async {
  if (!playerVisible) playerVisible = true;
  artwork = artworksData[(musicBox.get("artworksPointer") ??
          {})[nowMediaItem.extras!["id"]]] ??
      defaultNone!;
  try {
    advanceAudioData =
        await on_audio_edit.OnAudioEdit().readAudio(nowMediaItem.id);
  } catch (e) {
    advanceAudioData = null;
  }

  if (initialart && listEquals(art, art2)) {
    first = true;
    art = artwork;
    initialart = false;
    if (backArtStateChange) {
      rootCrossfadeState.provideman();
      if (crossfadeStateChange) {
        globaltaste.provideman();
      }
    }
  } else if (!initialart && first) {
    art2 = artwork;
    if (!listEquals(art, art2)) {
      first = false;
    }
    if (backArtStateChange) {
      rootCrossfadeState.provideman();
      if (crossfadeStateChange) {
        globaltaste.provideman();
      }
    }
  } else if (!initialart && !first) {
    art = artwork;
    if (!listEquals(art, art2)) {
      first = true;
    }
    if (backArtStateChange) {
      rootCrossfadeState.provideman();
      if (crossfadeStateChange) {
        globaltaste.provideman();
      }
    }
  }
  if (musicBox.get("colorsDB") == null
      ? true
      : musicBox.get("colorsDB")[(musicBox.get("artworksPointer") ??
              {})[nowMediaItem.extras!['id']]] ==
          null) {
    if (artwork == defaultNone) {
      if (musicBox.get("dominantDefault") != null) {
        nowColor = Color(musicBox.get("dominantDefault"));
        nowContrast = Color(musicBox.get("contrastDefault"));
        isArtworkDark = musicBox.get("isArtworkDarkDefault");
      } else {
        await getImagePalette(MemoryImage(artwork!));
        musicBox.put("dominantDefault", nowColor.value);
        musicBox.put("contrastDefault", nowContrast.value);
        musicBox.put("isArtworkDarkDefault", isArtworkDark);
      }
    } else {
      await getImagePalette(MemoryImage(artwork!));
      Map colorDB = musicBox.get("colorsDB") ?? {};
      colorDB[(musicBox.get("artworksPointer") ??
          {})[nowMediaItem.extras!['id']]] = [
        nowColor.value,
        nowContrast.value,
        isArtworkDark
      ];
      musicBox.put("colorsDB", colorDB);
    }
  } else {
    nowColor = Color(musicBox.get("colorsDB")[
            (musicBox.get("artworksPointer") ?? {})[nowMediaItem.extras!['id']]]
        [0]);
    nowContrast = Color(musicBox.get("colorsDB")[
            (musicBox.get("artworksPointer") ?? {})[nowMediaItem.extras!['id']]]
        [1]);
    isArtworkDark = musicBox.get("colorsDB")[
        (musicBox.get("artworksPointer") ?? {})[nowMediaItem.extras!['id']]][2];
  }

  if (!isPlayerShown) {
    isPlayerShown = true;
    pc.show();
  }
}

getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  nowColor = (paletteGenerator.dominantColor!.color);
  double luminance = nowColor.computeLuminance();
  isArtworkDark = luminance <= 0.6 ? true : false;
  if (luminance <= 0.5) {
    try {
      var pal = paletteGenerator.lightMutedColor!.color;
      nowContrast = pal;
    } catch (e) {
      nowContrast = Colors.white;
    }
    if (nowColor == nowContrast) {
      nowContrast = paletteGenerator.darkMutedColor!.color;
    }
  } else {
    try {
      var pal = (paletteGenerator.darkMutedColor!.color);
      nowContrast = pal;
    } catch (e) {
      nowContrast = Colors.black;
    }

    if (nowColor == nowContrast) {
      nowContrast = paletteGenerator.lightMutedColor!.color;
    }
  }
  if ((luminance - nowContrast.computeLuminance()).abs() < 0.2) {
    if (luminance < 0.5) {
      nowContrast = Colors.white;
    } else {
      nowContrast = Colors.black;
    }
  }

  if (backArtStateChange) {
    if (crossfadeStateChange) {
      globaltaste.provideman();
    }
    rootCrossfadeState.provideman();
  }
}
