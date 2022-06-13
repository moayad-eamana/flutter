import 'dart:io';

import 'package:eamanaapp/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

firebase_Notification() async {
  await Firebase.initializeApp();

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description
    showBadge: true,

    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  //  Create an Android Notification Channel.

  //  We use this channel in the `AndroidManifest.xml` file to override the
  //  default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
}

listenToFirbaseNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      print(message.data);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            visibility: NotificationVisibility.public,
            color: Colors.blue,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (message.data["module_name"] == "Offers") {
      navigatorKey.currentState?.pushNamed("/EamanaDiscount");
      return;
    }
    if (message.data["group"] == "update") {
      if (Platform.isAndroid) {
        launch("https://play.google.com/apps/internaltest/4701378476454016517");
      } else {
        launch("https://testflight.apple.com/join/NCmeNY0Q");
      }
    }
    print("onMessageOpenedApp: $message");
  });

  FirebaseMessaging.instance.getInitialMessage().then((message) async {
    if (message != null) {
      if (message.data["module_name"] == "Offers") {
        navigatorKey.currentState?.pushNamed("/EamanaDiscount");
        return;
      }
      if (message.data["group"] == "update") {
        if (Platform.isAndroid) {
          launch(
              "https://play.google.com/apps/internaltest/4701378476454016517");
        } else {
          launch("https://testflight.apple.com/join/NCmeNY0Q");
        }
      }
    }
  });
}
