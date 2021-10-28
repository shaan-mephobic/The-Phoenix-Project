// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';

visualizerNotificationInit() async {
  ///TODO setup new notification method. Whenever app is restarted, app crashes.
  // await AwesomeNotifications().initialize(
  //     // set the icon to null if you want to use the default app icon
  //     'resource://drawable/phoenix_awaken',
  //     // null,
  //     [
  //       NotificationChannel(
  //         channelKey: 'phoenix_visualize',
  //         channelName: 'Phoenix Visualizer',
  //         channelDescription: 'Phoenix Visualizer Running Alert',
  //         enableLights: false,
  //         enableVibration: false,
  //         importance: NotificationImportance.Default,
  //         playSound: false,
  //       )
  //     ]);
}

startVisualizerNotification() async {
  // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //   if (!isAllowed) {
  //     // Insert here your friendly dialog box before call the request method
  //     // This is very important to not harm the user experience
  //     AwesomeNotifications().requestPermissionToSendNotifications();
  //   }
  // });
  // await AwesomeNotifications().createNotification(
  //   content: NotificationContent(
  //     id: 69,
  //     channelKey: 'phoenix_visualize',
  //     locked: true,
  //     title: 'Phoenix Visualizing Music',
  //     displayedLifeCycle: NotificationLifeCycle.AppKilled,
  //     autoCancel: false,
  //     body: 'Running in background',
  //     backgroundColor: Colors.black,
  //   ),
  // );
}

stopVisualizerNotification() async {
  // await AwesomeNotifications().dismiss(69);
}
