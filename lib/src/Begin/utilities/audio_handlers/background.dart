import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  List<MediaItem> queue = [];
  final AudioPlayer _audioPlayer = AudioPlayer(
    handleInterruptions: true,
    androidApplyAudioAttributes: true,
    handleAudioSessionActivation: true,
  );
  int indexOfQueue = 0;
  int addToQueueIndex = -1;
  AudioProcessingState _skipState;
  StreamSubscription<PlaybackEvent> _eventSubscription;
  ConcatenatingAudioSource source;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    // Broadcast that we're connecting, and what controls are available.
    _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
      _broadcastState();
    });
    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        AudioServiceBackground.setMediaItem(queue[index]);
        indexOfQueue = index;
        if (addToQueueIndex == index) {
          addToQueueIndex = -1;
        }
      }
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      // ... and forward them to all audio_service clients.
      AudioServiceBackground.setState(
        playing: playerState.playing,
        // Every state from the audio player gets mapped onto an audio_service state.
        processingState: {
          ProcessingState.idle: AudioProcessingState.none,
          ProcessingState.loading: AudioProcessingState.connecting,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[playerState.processingState],
      );
    });

    _audioPlayer.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          break;
        case ProcessingState.ready:
          _skipState = null;
          break;
        default:
          break;
      }
    });
  }

  @override
  Future<void> onCustomAction(String name, dynamic arguments) async {}

  @override
  Future<void> onAddQueueItem(MediaItem mediaItem) async {
    if (addToQueueIndex == -1) {
      addToQueueIndex = indexOfQueue + 1;
    } else {
      addToQueueIndex += 1;
    }
    queue.insert(addToQueueIndex, mediaItem);
    source.insert(addToQueueIndex, AudioSource.uri(Uri.parse(mediaItem.id)));
  }

  @override
  Future<void> onAddQueueItemAt(MediaItem mediaItem, int index) async {
    queue.insert(index, mediaItem);
  }

  @override
  Future<void> onUpdateQueue(List mediaItems) async {
    queue = mediaItems;
    source = ConcatenatingAudioSource(
      children:
          queue.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
    );
    await _audioPlayer.setAudioSource(source, preload: false, initialIndex: 0);
    AudioServiceBackground.setMediaItem(queue[0]);
    _audioPlayer.setLoopMode(LoopMode.all);
    addToQueueIndex = -1;
  }

  @override
  Future<void> onSetShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.all)
      _audioPlayer.setShuffleModeEnabled(true);
    else
      _audioPlayer.setShuffleModeEnabled(false);
  }

  @override
  Future<void> onSetRepeatMode(AudioServiceRepeatMode loopMode) async {
    if (loopMode == AudioServiceRepeatMode.one)
      _audioPlayer.setLoopMode(LoopMode.one);
    else
      _audioPlayer.setLoopMode(LoopMode.all);
  }

  @override
  Future<void> onPlay() async {
    _audioPlayer.play();
  }

  @override
  Future<void> onClick(MediaButton button) async {
    switch (button) {
      case MediaButton.next:
        onSkipToNext();
        break;
      case MediaButton.previous:
        onSkipToPrevious();
        break;
      case MediaButton.media:
        if (_audioPlayer.playing) {
          await _audioPlayer.pause();
        } else {
          AudioService.play();
        }
        break;
    }
  }

  @override
  Future<void> onPause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> onStop() async {
    // Stop playing audio.
    _audioPlayer.stop();
    _eventSubscription.cancel();
    await _broadcastState();
    // Broadcast that we've stopped.
    await AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.stopped);
    // Shut down this background task
    await super.onStop();
  }

  @override
  Future<void> onFastForward() => _seekRelative(fastForwardInterval);

  @override
  Future<void> onRewind() => _seekRelative(-rewindInterval);

  // Jumps away from the current position by [offset].
  Future<void> _seekRelative(Duration offset) async {
    print("works?");
    var newPosition = _audioPlayer.position + offset;
    // Make sure we don't jump out of bounds.
    if (newPosition < Duration.zero) newPosition = Duration.zero;
    if (newPosition > queue[indexOfQueue].duration)
      newPosition = queue[indexOfQueue].duration;
    // Perform the jump via a seek.
    await _audioPlayer.seek(newPosition);
  }

  @override
  Future<void> onSkipToPrevious() async {
    _audioPlayer.seekToPrevious();
    if (!_audioPlayer.playing) _audioPlayer.play();
  }

  @override
  Future<void> onSkipToNext() async {
    _audioPlayer.seekToNext();
    if (!_audioPlayer.playing) _audioPlayer.play();
  }

  @override
  Future<void> onSeekTo(Duration position) => _audioPlayer.seek(position);

  Future<void> onTaskRemoved() async {
    await onStop();
  }

  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: [
        MediaAction.seekTo,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      ],
      androidCompactActions: const [0, 1, 2],
      processingState: _getProcessingState(),
      playing: _audioPlayer.playing,
      position: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
    );
  }

  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState;
    switch (_audioPlayer.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_audioPlayer.processingState}");
    }
  }
}
