import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phoenix/src/Begin/utilities/visualizer_notification.dart';

bool activeSession = false;
const platform = const MethodChannel("com.Phoenix.project/kotlin");

kotlinVisualizer() async {
  try {
    if (await Permission.microphone.request().isGranted) {
      await platform.invokeMethod("KotlinVisualizer");
      activeSession = true;
      await startVisualizerNotification();
    }
  } catch (e) {
    print(e);
  }
}

stopkotlinVisualizer() async {
  try {
    await platform.invokeMethod("ResetKot");
    activeSession = false;
    await stopVisualizerNotification();
  } catch (e) {
    print(e);
  }
}

goSensitivity(value) async {
  try {
    var data = <String, double>{"valueFromFlutter": value};
    await platform.invokeMethod("sensitivityKot", data);
  } catch (e) {
    print(e);
  }
}

checkWallpaperSupport() async {
  try {
    await platform.invokeMethod("wallpaperSupport?");
  } catch (e) {
    print(e);
  }
}

setHomeScreenWallpaper() async {
  try {
    await platform.invokeMethod("homescreen");
  } catch (e) {
    print(e);
  }
}

returnToOld() async {
  try {
    await platform.invokeMethod("returnToOld");
  } catch (e) {
    print(e);
  }
}

deleteAFile(path) async {
  try {
    var data = <String, String>{"fileToDelete": path};
    await platform.invokeMethod("deleteFile", data);
  } catch (e) {
    print(e);
  }
}

broadcastFileChange(String path) async {
  try {
    var data = <String, String>{"filePath": path};
    await platform.invokeMethod("broadcastFileChange", data);
  } catch (e) {
    print(e);
  }
}

setRingtone(String path) async {
  try {
    var data = <String, String>{'path': path};
    await platform.invokeMethod("setRingtone", data);
  } catch (e) {
    print(e);
  }
}
