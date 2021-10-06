import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/background.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

double deviceWidth;
double deviceHeight;
bool orientedCar = false;
Uint8List art;
Uint8List art2 = art;
Uint8List defaultArt;
Uint8List defaultNone;
Uint8List artwork;
Color nowColor = Color(0xFF091e25);
Color nowContrast = Color(0xFF8296a4);
Audiotagger tag;
Random random = Random();
bool refresh = false;
bool permissionGiven = false;
var musicBox;
bool crossfadeStateChange = false;
bool phoenixVisualizerShown = true;
bool fadeBool = true;
bool playerVisible = false;
bool initialart = true;
bool first = false;
List<SongModel> songList = [];
List specificAlbums = [];
List<MediaItem> songListMediaItems = [];
MediaItem nowMediaItem = MediaItem(
    title: "",
    id: "",
    album: "",
    artist: "",
    duration: Duration(seconds: 69),
    extras: {"id": 69420});
List<MediaItem> nowQueue = [];
int indexOfList;
AudioPlayerTask audioHandler;
bool backArtStateChange = true;
PanelController pc = PanelController();
Directory applicationFileDirectory;
var rootCrossfadeState;
var rootState;
var globalBigNow;
var animatedPlayPause;
bool swapController = false;
bool bgPhoenixVisualizer = false;
bool isAndroid11 = false;
bool ascend = false;
bool isPlayerShown = false;
ImageFilter glassBlur;
Color glassOpacity;
double glassShadowOpacity;
bool isArtworkDark = true;
bool onLyrics = false;
bool isFlashin = false;
bool loopSelected = false;
double defaultSensitivity = 50.0;
bool shuffleSelected = false;
BorderRadius radiusFullscreen = BorderRadius.only(
  topLeft: Radius.circular(deviceWidth / 40),
  topRight: Radius.circular(deviceWidth / 40),
);