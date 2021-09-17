String aestheticText(String title) {
  String roundedRecursive(String songName) {
    while (true) {
      if (songName.contains("(") && songName.contains(")")) {
        songName = songName.replaceRange(
            songName.indexOf("("), songName.indexOf(")") + 1, "");
      } else {
        return songName;
      }
    }
  }

  String squareRecursive(String songName) {
    while (true) {
      if (songName.contains("[") && songName.contains("]")) {
        songName = songName.replaceRange(
            songName.indexOf("["), songName.indexOf("]") + 1, "");
      } else {
        return songName;
      }
    }
  }

  String filter1 = roundedRecursive(title);
  filter1 = squareRecursive(filter1);
  if (filter1.toUpperCase().contains(" FEAT")) {
    filter1 = filter1.replaceRange(
        filter1.toUpperCase().indexOf(" FEAT"), filter1.length, "");
  }
  if (filter1.toUpperCase().contains(" FT")) {
    filter1 = filter1.replaceRange(
        filter1.toUpperCase().indexOf(" FT"), filter1.length, "");
  }
  return filter1;
}
