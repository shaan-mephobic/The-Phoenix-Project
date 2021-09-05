import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phoenix/src/Begin/pages/albums/albums.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/quick_tips.dart';
import 'utilities/page_backend/mansion_back.dart';
import 'package:phoenix/src/Begin/pages/now_playing/mini_playing.dart';
import 'package:phoenix/src/Begin/pages/playlist/playlist.dart';
import 'package:phoenix/src/Begin/pages/settings/settings.dart';
import 'pages/tracks/tracks.dart';
import 'utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/Begin/pages/genres/genres.dart';
import 'package:phoenix/src/Begin/pages/artists/artists.dart';
import 'utilities/page_backend/genres_back.dart';
import 'package:phoenix/src/Begin/pages/search/search.dart';
import 'package:phoenix/src/Begin/utilities/init.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/pages/mansion/mansion.dart';
import 'package:phoenix/src/Begin/utilities/constants.dart';
import 'package:phoenix/src/Begin/widgets/custom/physics.dart';
import 'package:phoenix/src/Begin/utilities/has_network.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/Begin/utilities/tab_bar.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/visualizer_notification.dart';
import 'package:phoenix/src/Begin/utilities/scraping/image_scrape.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'widgets/custom/phoenix_icon.dart';
import 'utilities/native/go_native.dart';
import 'utilities/page_backend/albums_back.dart';
import 'pages/albums/albums.dart';
import 'pages/now_playing/now_playing.dart';
import 'package:flutter_remixicon/flutter_remixicon.dart';

double deviceWidth;
int indexOfList;
Uint8List art;
bool refresh = false;
var tag;
Random random = Random();
Color statusBarColor = Colors.transparent;
bool permissionGiven = false;
List specificAlbums = [];
var musicBox;
Color nowColor = Color(0xFF091e25);
Color nowContrast = Color(0xFF8296a4);
bool crossfadeStateChange = false;
bool phoenixVisualizerShown = true;
Uint8List art2 = art;
bool fadeBool = true;
bool widgetvisible = false;
Uint8List artwork;
bool initialart = true;
bool first = false;
double deviceHeight;
List<SongModel> songList = [];
var rootCrossfadeState;
bool backArtStateChange = true;
PanelController pc = PanelController();
List<MediaItem> songListMediaItems = [];
MediaItem nowMediaItem = MediaItem(
    title: "",
    id: "",
    album: "",
    artist: "",
    duration: Duration(seconds: 69),
    extras: {"id": 69420});
List<MediaItem> nowQueue = [];
Directory applicationFileDirectory;
TabController _tabController;
var rootState;
bool orientedCar = false;
bool bgPhoenixVisualizer = false;
Uint8List defaultArt;
Uint8List defaultNone;
bool isAndroid11 = false;
bool ascend = false;
bool isPlayerShown = false;

class Begin extends StatefulWidget {
  final TabController tabController;
  Begin({this.tabController});
  @override
  _BeginState createState() => _BeginState();
}

class _BeginState extends State<Begin>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool exitapp = false;
  bool isonexit = false;
  bool stackedPhoenix = false;

  @override
  void initState() {
    audioServiceInit();
    _tabController = TabController(vsync: this, length: 6, initialIndex: 1);
    tag = Audiotagger();
    lazyLoad();
    visualizerNotificationInit();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    animatedPlayPause.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print("nothing to you");
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (onSettings) {
          yeahRotate();
        }
        break;
      case AppLifecycleState.paused:
        breakRotate = true;
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  Future<bool> didPopRoute() async {
    return false;
  }

  lazyLoad() async {
    if (ascend) {
      await fetchSongs();
    }
    await gettinAlbums();
    await songListToMediaItem();
    await gettinArtists();
    await gettinMansion();
    await gettinAlbumsArts();
    await gettinArtistsAlbums();
    await gettinGenres();
    await smartArtistsArts();
    ascend = true;
    print("ASCENDED");
    rootState.provideman();
    if (musicBox.get("isolation") == null
        ? true
        : !musicBox.get("isolation") && await hasNetwork()) {
      /// TODO do scraping only when phone's awake so you don't get HandshakeException: Connection terminated during handshake
      await isolatedArtistScrapeInit();
    }
  }

  songListToMediaItem() async {
    applicationFileDirectory = await getApplicationDocumentsDirectory();
    songListMediaItems = [];
    for (int i = 0; i < songList.length; i++) {
      MediaItem item = MediaItem(
          id: songList[i].data,
          album: songList[i].album,
          artist: songList[i].artist,
          duration: Duration(milliseconds: getDuration(songList[i])),
          artUri: Uri.file(allAlbumsName.contains(songList[i].album)
              ? musicBox.get("AlbumsWithoutArt") == null
                  ? "${applicationFileDirectory.path}/artworks/${songList[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
                  : musicBox.get("AlbumsWithoutArt").contains(songList[i].album)
                      ? "${applicationFileDirectory.path}/artworks/null.jpeg"
                      : "${applicationFileDirectory.path}/artworks/${songList[i].album.replaceAll(RegExp(r'[^\w\s]+'), '')}.jpeg"
              : "${applicationFileDirectory.path}/artworks/null.jpeg"),
          title: songList[i].title,
          extras: {"id": songList[i].id});

      songListMediaItems.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (musicBox.get("timeBasedDark") == null
        ? false
        : musicBox.get("timeBasedDark")) {
      if (DateTime.now().hour < 19 && DateTime.now().hour > 6) {
        musicBox.put("timeBasedDark", false);
        musicBox.put("dynamicArtDB", true);
        musicBox.put("timeBasedDark", false);
      }
    }

    if (refresh) {
      print("Refreshing...");
      refresh = false;
      lazyLoad();
    }
    orientedCar = false;

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    bool darkModeOn = true;

    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }
    rootCrossfadeState = Provider.of<Leprovider>(context);
    rootState = Provider.of<Leprovider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SlidingUpPanel(
          parallaxEnabled: true,
          isDraggable: true,
          backdropColor: Colors.black,
          minHeight: 60,
          controller: pc,
          borderRadius: musicBox.get("classix") ?? true
              ? null
              : BorderRadius.only(
                  topLeft: Radius.circular(deviceWidth / 40),
                  topRight: Radius.circular(deviceWidth / 40)),
          backdropEnabled: true,
          onPanelOpened: () {
            if (musicBox.get("quickTip") == null) {
              musicBox.put("quickTip", true);
              quickTip(context);
            }
          },
          onPanelClosed: () {
            if (isPlayerShown) {
              rootState.provideman();
            }
          },
          // collapsed: CollapsedPlaying(),
          collapsed:
              musicBox.get("classix") ?? true ? Classix() : Moderna(),
          maxHeight: deviceHeight,
          backdropTapClosesPanel: true,
          renderPanelSheet: true,
          color: Colors.transparent,
          panel: NowPlaying(),

          body: Container(
            color: Colors.black,
            child: Stack(
              children: [
                BackArt(),
                SafeArea(
                  top: true,
                  child: Column(
                    children: [
                      Container(
                        width: orientedCar ? deviceHeight : deviceWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.only(top: deviceHeight / 100)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Stack(
                                  children: [
                                    Visibility(
                                      visible: stackedPhoenix,
                                      child: Text(
                                        "  PHOENIX",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: orientedCar
                                                ? deviceWidth / 16
                                                : deviceHeight / 32,
                                            fontFamily: "NightMachine"),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Visibility(
                                      visible: !stackedPhoenix,
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            "  PHOENIX",
                                            cursor: " ",
                                            speed: Duration(milliseconds: 70),
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: orientedCar
                                                    ? deviceWidth / 16
                                                    : deviceHeight / 32,
                                                fontFamily: "NightMachine"),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                        isRepeatingAnimation: false,
                                        onFinished: () {
                                          stackedPhoenix = true;
                                          rootState.provideman();
                                        },
                                      ),
                                      // );
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: orientedCar
                                        ? deviceWidth > 400
                                            ? 5
                                            : 0
                                        : deviceHeight > 900
                                            ? 5
                                            : 0)),
                            TabBar(
                              unselectedLabelColor:
                                  musicBox.get("dynamicArtDB") ?? true
                                      ? Colors.white24
                                      : darkModeOn
                                          ? Colors.white24
                                          : Colors.black12,
                              labelColor: musicBox.get("dynamicArtDB") ?? true
                                  ? Colors.white
                                  : darkModeOn
                                      ? Colors.white
                                      : Colors.black,
                              indicatorWeight: 0.000001,
                              isScrollable: true,
                              enableFeedback: false,
                              physics: ScrollPhysics(),
                              controller: _tabController,
                              tabs: tabsData(deviceWidth, deviceHeight),
                              indicatorColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.only(bottom: isPlayerShown ? 60 : 0),
                          child: TabBarView(
                            physics: CustomPageViewScrollPhysics(),
                            controller: _tabController,
                            children: [
                              Mansion(),
                              Allofem(),
                              Albums(),
                              Artists(),
                              Genres(),
                              Playlist()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  right: true,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: deviceHeight / 100,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Color(0xFF05464f),
                                child: Icon(
                                  Phoenixtest.svging,
                                  color: musicBox.get("dynamicArtDB") ?? true
                                      ? bgPhoenixVisualizer
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.4)
                                      : darkModeOn
                                          ? bgPhoenixVisualizer
                                              ? Colors.white
                                              : Colors.white38
                                          : bgPhoenixVisualizer
                                              ? Colors.black
                                              : Colors.black38,
                                  size: orientedCar
                                      ? deviceWidth / 16
                                      : deviceHeight / 36,
                                ),
                                onTap: () async {
                                  if (bgPhoenixVisualizer) {
                                    stopkotlinVisualizer();
                                    rootState.provideman();
                                    bgPhoenixVisualizer = false;
                                    isFlashin = false;
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder:
                                              (context, StateSetter setState) {
                                            return Center(
                                              child: SingleChildScrollView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 0,
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          child: Container(
                                                            height: orientedCar
                                                                ? deviceHeight /
                                                                    1.4
                                                                : deviceWidth *
                                                                    1.3,
                                                            width: orientedCar
                                                                ? deviceHeight /
                                                                    1.5
                                                                : deviceWidth /
                                                                    1.2,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          kRounded),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          kRounded),
                                                              // make sure we apply clip it properly
                                                              child:
                                                                  BackdropFilter(
                                                                filter: ImageFilter
                                                                    .blur(
                                                                        sigmaX:
                                                                            20,
                                                                        sigmaY:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              kRounded),
                                                                      border: Border.all(
                                                                          color: Colors.white.withOpacity(
                                                                              0.04)),
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.05)),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Text(
                                                                        "PHOENIX VISUALIZER",
                                                                        style:
                                                                            TextStyle(
                                                                          inherit:
                                                                              false,
                                                                          color: darkModeOn
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                          fontFamily:
                                                                              "UrbanB",
                                                                          fontSize:
                                                                              deviceWidth / 14,
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            SleekCircularSlider(
                                                                          appearance:
                                                                              CircularSliderAppearance(
                                                                            infoProperties:
                                                                                InfoProperties(
                                                                              bottomLabelStyle: TextStyle(
                                                                                inherit: false,
                                                                                fontFamily: 'InterR',
                                                                                color: darkModeOn ? Colors.white : Colors.black,
                                                                                fontSize: deviceHeight / 60,
                                                                              ),
                                                                              bottomLabelText: 'SENSITIVITY',
                                                                              mainLabelStyle: TextStyle(inherit: false, fontFamily: 'InterR', color: darkModeOn ? Colors.white : Colors.black, fontSize: deviceHeight / 40, fontWeight: FontWeight.w400),
                                                                            ),
                                                                            size:
                                                                                deviceHeight / 6,
                                                                            customColors:
                                                                                CustomSliderColors(
                                                                              progressBarColor: darkModeOn ? Color(0xFFCF6679) : Color(0xFFB00020),
                                                                            ),
                                                                            customWidths:
                                                                                CustomSliderWidths(progressBarWidth: deviceWidth / 65),
                                                                          ),
                                                                          min:
                                                                              0,
                                                                          max:
                                                                              100,
                                                                          initialValue:
                                                                              defaultSensitivity,
                                                                          onChange:
                                                                              (double value) async {
                                                                            goSensitivity(35 +
                                                                                (value * 0.3));
                                                                            defaultSensitivity =
                                                                                value;
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Material(
                                                                        borderRadius:
                                                                            BorderRadius.circular(kRounded),
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            InkWell(
                                                                          borderRadius:
                                                                              BorderRadius.circular(kRounded),
                                                                          onTap:
                                                                              () {
                                                                            bgPhoenixVisualizer =
                                                                                true;
                                                                            if (!isFlashin) {
                                                                              isFlashin = true;
                                                                              kotlinVisualizer();
                                                                            }

                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                deviceWidth / 12,
                                                                            width:
                                                                                deviceWidth / 4,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF1DB954),
                                                                              borderRadius: BorderRadius.circular(kRounded),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Text("START", textAlign: TextAlign.center, style: TextStyle(inherit: false, color: Colors.black, fontSize: deviceWidth / 25, fontFamily: 'UrbanSB')),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left: deviceWidth /
                                                                                10,
                                                                            right:
                                                                                deviceWidth / 10),
                                                                        child:
                                                                            Text(
                                                                          "NOTE: This will run in the background until stopped, causing battery drain",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          maxLines:
                                                                              2,
                                                                          style: TextStyle(
                                                                              inherit: false,
                                                                              color: darkModeOn ? Colors.white : Colors.black,
                                                                              fontSize: deviceWidth / 30,
                                                                              fontFamily: 'UrbanR'),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                    rootState.provideman();
                                  }
                                },
                                onLongPress: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder:
                                            (context, StateSetter setState) {
                                          return Center(
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 0,
                                                    child: Container(
                                                      height: orientedCar
                                                          ? deviceHeight / 1.4
                                                          : deviceWidth * 1.3,
                                                      width: orientedCar
                                                          ? deviceHeight / 1.5
                                                          : deviceWidth / 1.2,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    kRounded),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    kRounded),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 20,
                                                                  sigmaY: 20),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            kRounded),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.04)),
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.05)),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  "PHOENIX VISUALIZER",
                                                                  style:
                                                                      TextStyle(
                                                                    inherit:
                                                                        false,
                                                                    color: darkModeOn
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontFamily:
                                                                        "UrbanB",
                                                                    fontSize:
                                                                        deviceWidth /
                                                                            14,
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      SleekCircularSlider(
                                                                    appearance:
                                                                        CircularSliderAppearance(
                                                                      // animationEnabled: sensitivityanimation,
                                                                      infoProperties:
                                                                          InfoProperties(
                                                                        bottomLabelStyle:
                                                                            TextStyle(
                                                                          inherit:
                                                                              false,

                                                                          fontFamily:
                                                                              'InterR',
                                                                          color: darkModeOn
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                          fontSize:
                                                                              deviceHeight / 60,
                                                                          // fontWeight: FontWeight.w600
                                                                        ),
                                                                        bottomLabelText:
                                                                            'SENSITIVITY',
                                                                        mainLabelStyle: TextStyle(
                                                                            inherit:
                                                                                false,
                                                                            fontFamily:
                                                                                'InterR',
                                                                            color: darkModeOn
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            fontSize: deviceHeight / 40,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                      size:
                                                                          deviceHeight /
                                                                              6,
                                                                      customColors:
                                                                          CustomSliderColors(
                                                                        progressBarColor: darkModeOn
                                                                            ? Color(0xFFCF6679)
                                                                            : Color(0xFFB00020),
                                                                      ),

                                                                      customWidths:
                                                                          CustomSliderWidths(
                                                                              progressBarWidth: deviceWidth / 65),
                                                                    ),
                                                                    min: 0,
                                                                    max: 100,
                                                                    initialValue:
                                                                        defaultSensitivity,
                                                                    onChange:
                                                                        (double
                                                                            value) async {
                                                                      goSensitivity(35 +
                                                                          (value *
                                                                              0.3));
                                                                      defaultSensitivity =
                                                                          value;
                                                                    },
                                                                  ),
                                                                ),
                                                                Material(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              kRounded),
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            kRounded),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          deviceWidth /
                                                                              12,
                                                                      width:
                                                                          deviceWidth /
                                                                              4,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFF1DB954),
                                                                        borderRadius:
                                                                            BorderRadius.circular(kRounded),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            "DONE",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: TextStyle(
                                                                                inherit: false,
                                                                                color: Colors.black,
                                                                                fontSize: deviceWidth / 25,
                                                                                fontFamily: 'UrbanSB')),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: DateTime.now().hour >= 19 ||
                                    DateTime.now().hour <= 6
                                ? true
                                : false,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: orientedCar
                                      ? deviceHeight / 32
                                      : deviceWidth / 16),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Icon(
                                    musicBox.get("timeBasedDark") == null
                                        ? MIcon.riMoonLine
                                        : musicBox.get("timeBasedDark")
                                            ? MIcon.riMoonFill
                                            : MIcon.riMoonLine,
                                    color: Colors.white,
                                    size: orientedCar
                                        ? deviceWidth / 16
                                        : deviceHeight / 36,
                                  ),
                                  onTap: () async {
                                    if (!(musicBox.get("timeBasedDark") == null
                                        ? false
                                        : musicBox.get("timeBasedDark"))) {
                                      await musicBox.put("timeBasedDark", true);
                                      await musicBox.put("dynamicArtDB", false);

                                      musicBox.put("timeBasedDark", true);
                                    } else {
                                      await musicBox.put(
                                          "timeBasedDark", false);
                                      await musicBox.put("dynamicArtDB", true);

                                      musicBox.put("timeBasedDark", false);
                                    }

                                    rootState.provideman();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: orientedCar
                                    ? deviceHeight / 32
                                    : deviceWidth / 16),
                            child: Hero(
                              tag: "aslongasiwakeup",
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Icon(
                                    MIcon.riSearchLine,
                                    color: musicBox.get("dynamicArtDB") ?? true
                                        ? Colors.white
                                        : darkModeOn
                                            ? Colors.white
                                            : Colors.black,
                                    size: orientedCar
                                        ? deviceWidth / 17
                                        : deviceHeight / 36,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MultiProvider(
                                          providers: [
                                            ChangeNotifierProvider<
                                                Astronautintheocean>(
                                              create: (_) =>
                                                  Astronautintheocean(),
                                            ),
                                            ChangeNotifierProvider<Leprovider>(
                                              create: (_) => Leprovider(),
                                            ),
                                          ],
                                          builder: (context, child) =>
                                              Searchin(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: orientedCar
                                    ? deviceHeight / 32
                                    : deviceWidth / 16,
                                right: orientedCar
                                    ? deviceHeight / 80
                                    : deviceWidth / 40),
                            child: Hero(
                              tag: "fortress",
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Icon(
                                    Ionicons.settings_outline,
                                    color: musicBox.get("dynamicArtDB") ?? true
                                        ? Colors.white
                                        : darkModeOn
                                            ? Colors.white
                                            : Colors.black,
                                    size: orientedCar
                                        ? deviceWidth / 17
                                        : deviceHeight / 36,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        maintainState: true,
                                        builder: (context) => MultiProvider(
                                          providers: [
                                            ChangeNotifierProvider<Leprovider>(
                                              create: (_) => Leprovider(),
                                            ),
                                            ChangeNotifierProvider<MrMan>(
                                              create: (_) => MrMan(),
                                            ),
                                          ],
                                          builder: (context, child) =>
                                              Settings(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (pc.isPanelOpen) {
      pc.close();
      rootState.provideman();
      return false;
    } else if (pc.isPanelClosed && !isonexit) {
      isonexit = true;

      fivesecsbacker();

      return false;
    } else if (pc.isPanelClosed && isonexit) {
      return true;
    }
    return false;
  }

  fivesecsbacker() async {
    await Future.delayed(Duration(seconds: 5));
    isonexit = false;
    exitapp = false;
  }
}
