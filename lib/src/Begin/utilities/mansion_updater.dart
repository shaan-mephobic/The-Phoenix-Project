import '../begin.dart';


updateData(data) async {
  var isnull = musicBox.get('crossfire');

  if (isnull == null) {
    musicBox.put('crossfire', {});
  }
  Map dBase = musicBox.get('crossfire');
  int recent = dBase.length + 1;
  if (dBase[data] == null) {
    dBase[data] = [1, nowMediaItem.artist, nowMediaItem.album, recent];
  } else {
    int times = dBase[data][0];
    times += 1;
    dBase[data] = [times, nowMediaItem.artist, nowMediaItem.album, recent];
  }
  musicBox.put('crossfire', dBase);
}


