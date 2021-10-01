import 'dart:ui';
import 'package:audiotagger/audiotagger.dart';
import 'package:phoenix/src/Begin/pages/albums/albums.dart';
import 'package:phoenix/src/Begin/pages/now_playing/now_playing_sky.dart';
import 'package:phoenix/src/Begin/utilities/global_variables.dart';
import 'package:phoenix/src/Begin/widgets/custom/graviticons.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/phoenix_visualizer.dart';
import 'package:phoenix/src/Begin/widgets/dialogues/quick_tips.dart';
import 'package:phoenix/src/Begin/pages/now_playing/mini_playing.dart';
import 'package:phoenix/src/Begin/pages/playlist/playlist.dart';
import 'package:phoenix/src/Begin/pages/settings/settings.dart';
import 'pages/tracks/tracks.dart';
import 'package:phoenix/src/Begin/pages/genres/genres.dart';
import 'package:phoenix/src/Begin/pages/artists/artists.dart';
import 'package:phoenix/src/Begin/pages/search/search.dart';
import 'package:phoenix/src/Begin/utilities/init.dart';
import 'package:phoenix/src/Begin/widgets/artwork_background.dart';
import 'package:phoenix/src/Begin/pages/mansion/mansion.dart';
import 'package:phoenix/src/Begin/widgets/custom/physics.dart';
import 'package:phoenix/src/Begin/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/Begin/utilities/tab_bar.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/Begin/utilities/visualizer_notification.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'pages/albums/albums.dart';
import 'package:flutter_remixicon/flutter_remixicon.dart';

class Begin extends StatefulWidget {
  @override
  _BeginState createState() => _BeginState();
}

class _BeginState extends State<Begin>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool exitapp = false;
  bool isonexit = false;
  bool stackedPhoenix = false;
  TabController tabController;

  @override
  void initState() {
    audioServiceStream();
    tabController = TabController(vsync: this, length: 6, initialIndex: 1);
    tag = Audiotagger();
    fetchAll();
    visualizerNotificationInit();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    animatedPlayPause.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
      fetchAll();
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
          collapsed: musicBox.get("classix") ?? true ? Classix() : Moderna(),
          maxHeight: deviceHeight,
          backdropTapClosesPanel: true,
          renderPanelSheet: true,
          color: Colors.transparent,
          panel: NowPlayingSky(),
          body: Stack(
            children: [
              BackArt(),
              SafeArea(
                top: true,
                child: Column(
                  children: [
                    SizedBox(
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
                              SizedBox(
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
                            controller: tabController,
                            tabs: tabsData(deviceWidth, deviceHeight),
                            indicatorColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: isPlayerShown ? 60 : 0),
                        child: TabBarView(
                          physics: CustomPageViewScrollPhysics(),
                          controller: tabController,
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
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(
                                orientedCar
                                    ? deviceWidth / 16 / 2
                                    : deviceHeight / 36 / 2)),
                            child: Icon(
                              Graviticons.phoenix,
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
                              return await phoenixGlobal(context: context)
                                  .then((value) => rootState.provideman());
                            },
                            onLongPress: () async {
                              return await phoenixCustomize(context: context)
                                  .then((value) => rootState.provideman());
                            },
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    orientedCar
                                        ? deviceWidth / 16 / 2
                                        : deviceHeight / 36 / 2)),
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
                                    await musicBox.put("timeBasedDark", false);
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    orientedCar
                                        ? deviceWidth / 16 / 2
                                        : deviceHeight / 36 / 2)),
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
                                        builder: (context, child) => Searchin(),
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    orientedCar
                                        ? deviceWidth / 16 / 2
                                        : deviceHeight / 36 / 2)),
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
                                        builder: (context, child) => Settings(),
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
