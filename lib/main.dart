// @dart=2.10
import 'package:phoenix/src/Begin/widgets/custom/ripple.dart';
import 'package:phoenix/src/Begin/pages/settings/settings_pages/privacy.dart';
import 'package:phoenix/src/Begin/utilities/init.dart';
import 'package:phoenix/src/Begin/utilities/provider/provider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/Begin/begin.dart';

void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await cacheImages();
  await dataInit();
  await fetchSongs();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
    ),
  );
  runApp(
    MaterialApp(
      theme: ThemeData(
        splashFactory: CustomRipple.splashFactory,
        accentColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Leprovider>(create: (_) => Leprovider()),
          ChangeNotifierProvider<MrMan>(
            create: (_) => MrMan(),
          ),
          ChangeNotifierProvider<Seek>(create: (_) => Seek()),
        ],
        child: AudioServiceWidget(
          child: permissionGiven ? Begin() : Privacy(),
        ),
      ),
    ),
  );
}

