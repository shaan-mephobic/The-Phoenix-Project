import '../begin.dart';

aetheticText() {
  String runaway = roundedRecursive(nowMediaItem.title);
  runaway = squareRecursive(runaway);
  if (runaway.toUpperCase().contains(" FEAT")) {
    runaway = runaway.replaceRange(
        runaway.toUpperCase().indexOf(" FEAT"), runaway.length, "");
  }
  if (runaway.toUpperCase().contains(" FT")) {
    runaway = runaway.replaceRange(
        runaway.toUpperCase().indexOf(" FT"), runaway.length, "");
  }

  return runaway;
}

roundedRecursive(songName) {
  if (songName.contains("(") && songName.contains(")")) {
    songName = roundBracketsRemover(songName);
    if (songName.contains("(") && songName.contains(")")) {
      songName = roundBracketsRemover(songName);
      if (songName.contains("(") && songName.contains(")")) {
        songName = roundBracketsRemover(songName);
        if (songName.contains("(") && songName.contains(")")) {
          songName = roundBracketsRemover(songName);
        }
      }
    }
  }
  return songName;
}

squareRecursive(songName) {
  if (songName.contains("[") && songName.contains("]")) {
    songName = squareBracketsRemover(songName);
    if (songName.contains("[") && songName.contains("]")) {
      songName = squareBracketsRemover(songName);
      if (songName.contains("[") && songName.contains("]")) {
        songName = squareBracketsRemover(songName);
        if (songName.contains("[") && songName.contains("]")) {
          songName = squareBracketsRemover(songName);
          if (songName.contains("[") && songName.contains("]")) {
            songName = squareBracketsRemover(songName);
          }
        }
      }
    }
  }
  return songName;
}

squareBracketsRemover(songName) {
  songName = songName.replaceRange(
      songName.indexOf("["), songName.indexOf("]") + 1, "");

  return songName;
}

roundBracketsRemover(songName) {
  songName = songName.replaceRange(
      songName.indexOf("("), songName.indexOf(")") + 1, "");
  return songName;
}
