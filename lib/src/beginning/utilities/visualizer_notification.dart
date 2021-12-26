import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

visualizerNotificationInit() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/phoenix_awaken',
    [
      NotificationChannel(
        channelKey: 'phoenix_visualize',
        channelName: 'Phoenix Visualizer',
        channelDescription: 'Phoenix Visualizer Running Alert',
        enableLights: false,
        enableVibration: false,
        importance: NotificationImportance.Default,
        playSound: false,
      ),
    ],
  );
}

startVisualizerNotification() async {
  AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 69,
      channelKey: 'phoenix_visualize',
      locked: true,
      title: 'Phoenix Visualizing Music',
      body: 'Running in background',
      backgroundColor: Colors.black,
    ),
  );
}

stopVisualizerNotification() async {
  await AwesomeNotifications().dismiss(69);
}
