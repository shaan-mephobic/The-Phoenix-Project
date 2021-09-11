import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/Begin/begin.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:phoenix/src/Begin/widgets/custom/marquee.dart';
import '../../widgets/artwork_background.dart';

Map advanceAudioData = {};

playerontap() async {
  if (!widgetvisible) widgetvisible = true;
  artwork = await OnAudioQuery().queryArtwork(
          nowMediaItem.extras["id"], ArtworkType.AUDIO,
          format: ArtworkFormat.JPEG, size: 200) ??
      defaultNone;
  try {
    advanceAudioData = await tag.readAudioFileAsMap(path: nowMediaItem.id);
  } catch (e) {
    advanceAudioData = {};
  }
  if (!isMarqueeDead) {
    marqueeController.reset();
  }
  if (initialart && art == art2) {
    first = true;
    art = artwork;
    initialart = false;
    if (backArtStateChange) {
      rootCrossfadeState.provideman();
      if (crossfadeStateChange) {
        globaltaste.provideman();
      }
    }
  } else if (!initialart && fadeBool) {
    first = false;
    art2 = artwork;
    fadeBool = false;
    if (backArtStateChange) {
      rootCrossfadeState.provideman();
      if (crossfadeStateChange) {
        globaltaste.provideman();
      }
    }
  } else if (!initialart && !fadeBool) {
    first = true;
    art = artwork;
    fadeBool = true;
    if (backArtStateChange) {
      rootCrossfadeState.provideman();

      if (crossfadeStateChange) {
        globaltaste.provideman();
      }
    }
  }
  if (musicBox.get("colorsDB") == null
      ? true
      : musicBox.get("colorsDB")[nowMediaItem.id] == null) {
    if (artwork == defaultNone) {
      nowColor = Color(0xFF383643);
      nowContrast = Color(0xFFc9d1c8);
    } else {
      getImagePalette(MemoryImage(artwork));
    }
  } else {
    nowColor = Color(musicBox.get("colorsDB")[nowMediaItem.id][0]);
    nowContrast = Color(musicBox.get("colorsDB")[nowMediaItem.id][1]);
  }

  if (!isPlayerShown) {
    isPlayerShown = true;
    pc.show();
  }
}

getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  nowColor = (paletteGenerator.dominantColor.color);
  if (nowColor.computeLuminance() <= 0.5) {
    try {
      var pal = paletteGenerator.lightMutedColor.color;
      nowContrast = pal;
    } catch (e) {
      nowContrast = Colors.white;
    }
    if (nowColor == nowContrast) {
      nowContrast = paletteGenerator.darkMutedColor.color;
    }
  } else {
    try {
      var pal = (paletteGenerator.darkMutedColor.color);
      nowContrast = pal;
    } catch (e) {
      nowContrast = Colors.black;
    }

    if (nowColor == nowContrast) {
      nowContrast = paletteGenerator.lightMutedColor.color;
    }
  }
  if ((nowColor.computeLuminance() - nowContrast.computeLuminance()).abs() <
      0.2) {
    if (nowColor.computeLuminance() < 0.5) {
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
  Map colorDB = musicBox.get("colorsDB") ?? {};
  colorDB[nowMediaItem.id] = [nowColor.value, nowContrast.value];
  musicBox.put("colorsDB", colorDB);
}
